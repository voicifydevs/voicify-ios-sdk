//
//  VoicifyTTSProvider.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/28/22.
//

import Foundation
import AVFoundation
import SwiftUI
public class VoicifyTTSProivder : VoicifyTextToSpeechProvider, ObservableObject {
    private var settings: VoicifyTextToSpeechSettings
    private var speechEndHandlers: Array<() -> Void> = []
    private var speechErrorHandlers: Array<(String) -> Void> = []
    private var ttsResponse: Array<TTSData>? = nil
    private var currentPlayingIndex: Int = 0
    private var locale = ""
    public var cancelSpeech: Bool = false
    private var player: AVPlayer? = nil
    private var obeserver: NSObjectProtocol? = nil
    
    public init(settings: VoicifyTextToSpeechSettings){
        self.settings = settings
    }
    
    public func initialize(locale: String) {
        self.locale = locale
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onSpeechEnd),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: nil
        )
    }
    
    public func speakSsml(ssml: String) {
        do{
            let ttsRequestBody = generateTTSRequest(ssml: ssml)
            let encoder = JSONEncoder()
            guard let url = URL(string: "\(settings.serverRootUrl)/api/Ssml/toSpeech/\(settings.provider)") else { fatalError("Missing URL") }
            let encodedBody = try encoder.encode(ttsRequestBody)
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = encodedBody
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if error != nil {
                    return
                }
                guard let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        do {
                            self.ttsResponse = try JSONDecoder().decode([TTSData].self, from: data)
                            let audioUrl = self.ttsResponse?[0].url
                            guard let url = URL(string: audioUrl ?? "") else {return}
                            if (self.player != nil && self.player?.currentItem != nil)
                            {
                                if(self.ttsResponse?.count == 1)
                                {
                                    self.player?.replaceCurrentItem(with: AVPlayerItem(url: url))
                                    try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: .default)
                                    try AVAudioSession.sharedInstance().setActive(true)
                                    if(!self.cancelSpeech){
                                        self.player?.play()
                                    }
                                }
                            }
                            else{
                                let playerItem = AVPlayerItem(url: url)
                                self.player = AVPlayer(playerItem: playerItem)
                                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: .default)
                                try AVAudioSession.sharedInstance().setActive(true)
                                if(!self.cancelSpeech){
                                    self.player?.play()
                                }
                            }
                        } catch let error {
                            self.speechErrorHandlers.forEach{ speechErrorHandler in
                                speechErrorHandler(error.localizedDescription)
                            }
                        }
                    }
                }
            }.resume()
        }
        catch let error{
            speechErrorHandlers.forEach{ speechErrorHandler in
                speechErrorHandler(error.localizedDescription)
            }
        }
    }
    
    public func stop() {
        self.player?.replaceCurrentItem(with: nil)
        
    }
    
    @objc public func onSpeechEnd() -> Void{
        if let count = self.ttsResponse?.count{
            currentPlayingIndex+=1
            if (currentPlayingIndex < count)
            {
                playNext()
            }
            else{
                currentPlayingIndex = 0
                speechEndHandlers.forEach{speechEndHandler in
                    speechEndHandler()
                }
            }
        }
        else{
            speechEndHandlers.forEach{speechEndHandler in
                speechEndHandler()
            }
        }
        
    }
    
    public func addFinishListener(callback: @escaping () -> Void) {
        self.speechEndHandlers.append(callback)
    }
    
    public func addSpeechErrorListener(callback: @escaping (String) -> Void){
        self.speechErrorHandlers.append(callback)
    }
    
    private func playNext(){
        do{
            let audioUrl = self.ttsResponse?[currentPlayingIndex].url
            guard let url = URL(string: audioUrl ?? "") else {return}
            self.player?.replaceCurrentItem(with: AVPlayerItem(url: url))
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            self.player?.play()
        }
        catch let error {
            speechErrorHandlers.forEach{ speechErrorHandler in
                speechErrorHandler(error.localizedDescription)
            }
       }
    }
    
    private func generateTTSRequest(ssml: String) -> TTSRequest {
        return TTSRequest(
            applicationId: settings.appId,
            applicationSecret: settings.appKey,
            ssmlRequest: SsmlRequest(
                ssml: ssml,
                locale: self.locale,
                voice: settings.voice
            )
        )
    }
    
    public func clearHandlers() {
        self.speechEndHandlers = []
        self.speechErrorHandlers = []
    }
}
