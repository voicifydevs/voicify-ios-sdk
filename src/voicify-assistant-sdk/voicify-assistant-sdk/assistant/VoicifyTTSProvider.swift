//
//  VoicifyTTSProvider.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/28/22.
//

import Foundation
import AVFoundation
import SwiftUI
//https://stackoverflow.com/questions/29386531/how-to-detect-when-avplayer-video-ends-playing
public class VoicifyTTSProivder : VoicifyTextToSpeechProvider, ObservableObject {
    private var settings: VoicifyTextToSpeechSettings
    private var speechEndHandlers: Array<() -> Void> = []
    private var ttsResponse: Array<TTSData>? = nil
    private var currentPlayingIndex: Int = 0
    private var locale = ""
    private var cancelSpeech: Bool = false
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
                if let error = error {
                    print("Request error: ", error)
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
                            if (self.player != nil)
                            {
                                self.player?.replaceCurrentItem(with: AVPlayerItem(url: url))
                                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, mode: .default)
                                try AVAudioSession.sharedInstance().setActive(true)
                                self.player?.play()
                            }
                            else{
                                let playerItem = AVPlayerItem(url: url)
                                self.player = AVPlayer(playerItem: playerItem)
                                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: .default)
                                try AVAudioSession.sharedInstance().setActive(true)
                                self.player?.play()
                            }
                        } catch let error {
                            print("Error decoding: ", error)
                        
                        }
                    }
                }
            }.resume()
        }
        catch let ttsError{
            print(ttsError)
        }
    }
    
    public func stop() {
        self.player?.replaceCurrentItem(with: nil)
        
    }
    
    @objc public func onSpeechEnd() -> Void{
        speechEndHandlers.forEach{speechEndHandler in
            print("we are firing the speech end handlers")
            print(speechEndHandler)
            speechEndHandler()
        }
    }
 
    public func addFinishListener(callback: @escaping () -> Void) {
        print("we are adding the callback")
        self.speechEndHandlers.append(callback)
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
    }
}
