//
//  VoicifySTTProvider.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/26/22.
//

import AVFoundation
import Foundation
import Speech
import SwiftUI

public class VoicifySTTProvider : VoicifySpeechToTextProvider, ObservableObject
{
    private var speechStartHandlers: Array<() -> Void> = []
    private var speechReadyHandlers: Array<() -> Void> = []
    private var speechPartialHandlers: Array<(String) -> Void> = []
    private var speechEndHandlers: Array<() -> Void> = []
    private var speechResultHandlers: Array<(String) -> Void> = []
    private var speechErrorHandlers: Array<(String) -> Void> = []
    private var speechVolumeHandlers: Array<(Double) -> Void> = []
    private var locale: String = ""
    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private var recognizer: SFSpeechRecognizer?
    private var speechTimeOut = Timer()
    private var cancel = false
//    private var frameCount = 0
        
    public init() {
        
    }
    
    deinit {
        reset()
    }
    
    public func initialize(locale: String) {
        recognizer = SFSpeechRecognizer(locale: Locale.init(identifier: locale))
        
        Task(priority: .background) {
            do {
                guard recognizer != nil else {
                    throw RecognizerError.nilRecognizer
                }
                guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else {
                    throw RecognizerError.notAuthorizedToRecognize
                }
                guard await AVAudioSession.sharedInstance().hasPermissionToRecord() else {
                    throw RecognizerError.notPermittedToRecord
                }
            } catch {
                speechErrorHandlers.forEach{ speechErrorHandler in
                    speechErrorHandler(error.localizedDescription)
                }
            }
        }
    }
    
    public func startListening() {
        if !cancel
        {
            DispatchQueue(label: "Speech Recognizer Queue", qos: .background).async { [weak self] in
                guard let self = self, let recognizer = self.recognizer, recognizer.isAvailable else {
                    self?.speechErrorHandlers.forEach{ errorHandler in
                        errorHandler(RecognizerError.recognizerIsUnavailable.message)
                    }
                    return
                }
                do {
                    let (audioEngine, request) = try Self.prepareEngine()
                    self.audioEngine = audioEngine
                    self.request = request
                    self.task = recognizer.recognitionTask(with: request, resultHandler: self.recognitionHandler(result:error:))
                } catch {
                    self.reset()
                    self.speechErrorHandlers.forEach{ speechErrorHandler in
                        speechErrorHandler(error.localizedDescription)
                    }
                }
            }
        }
        
    }
    
    public func stopListening() {
        self.reset()
    }
    
    private static func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        let audioEngine = AVAudioEngine()
        
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            request.append(buffer)
        }
        audioEngine.prepare()
        try audioEngine.start()
        
        return (audioEngine, request)
    }
    
    private func recognitionHandler(result: SFSpeechRecognitionResult?, error: Error?) {
        
        let receivedError = error != nil
        if(receivedError)
        {
            speechTimeOut.invalidate()
            self.audioEngine?.stop()
            self.audioEngine?.inputNode.removeTap(onBus: 0)
            self.reset()
            self.speechErrorHandlers.forEach{ speechErrorHandler in
                speechErrorHandler(error?.localizedDescription ?? "")
            }
        }
        if speechTimeOut.isValid
        {
            speechTimeOut.invalidate()
            speechTimeOut = Timer.scheduledTimer(withTimeInterval: 0.9, repeats: false) { timer in
                self.audioEngine?.stop()
                self.audioEngine?.inputNode.removeTap(onBus: 0)
                if let result = result {
                    self.speechResultHandlers.forEach{fullResultHandler in
                        fullResultHandler(result.bestTranscription.formattedString)
                    }
                    self.reset()
                }
            }
        }
        else
        {
            speechTimeOut = Timer.scheduledTimer(withTimeInterval: 0.9, repeats: false) { timer in
                self.audioEngine?.stop()
                self.audioEngine?.inputNode.removeTap(onBus: 0)
                if let result = result {
                    self.speechResultHandlers.forEach{fullResultHandler in
                        fullResultHandler(result.bestTranscription.formattedString)
                    }
                    self.reset()
                }
            }
        }
        
        if let result = result {
            self.speechPartialHandlers.forEach{ partialResultHandler in
                partialResultHandler(result.bestTranscription.formattedString)
            }
//            self.speechVolumeHandlers.forEach{volumeHandler in
//                volumeHandler(result.speechRecognitionMetadata?.voiceAnalytics?.shimmer.acousticFeatureValuePerFrame[(result.speechRecognitionMetadata?.voiceAnalytics?.shimmer.acousticFeatureValuePerFrame.endIndex ?? 0) - 1] ?? 0)
//            }
        }
    }
    
    public func addStartListener(callback: @escaping () -> Void) {
        self.speechStartHandlers.append(callback)
    }
    
    public func addSpeechReadyListener(callback: @escaping () -> Void) {
        self.speechReadyHandlers.append(callback)
    }
    
    public func addPartialListener(callback: @escaping (String) -> Void) {
        self.speechPartialHandlers.append(callback)
    }
    
    public func addEndListener (callback: @escaping () -> Void){
        self.speechEndHandlers.append(callback)
    }
    
    public func addFinalResultListener(callback: @escaping (String) -> Void) {
        self.speechResultHandlers.append(callback)
    }
    
    public func addVolumeListener(callback: @escaping(Double) -> Void){
        self.speechVolumeHandlers.append(callback)
    }
    
    public func addErrorListener(callback: @escaping (String) -> Void) {
        self.speechErrorHandlers.append(callback)
    }
    
    public func reset() {
        task?.cancel()
        audioEngine?.stop()
        audioEngine = nil
        request = nil
        task = nil
    }
    
    public func clearHandlers() {
        self.speechStartHandlers = []
        self.speechPartialHandlers = []
        self.speechEndHandlers = []
        self.speechResultHandlers = []
        self.speechErrorHandlers = []
        self.speechVolumeHandlers = []
        self.speechReadyHandlers = []
    }
    
    enum RecognizerError: Error {
        case nilRecognizer
        case notAuthorizedToRecognize
        case notPermittedToRecord
        case recognizerIsUnavailable
        
        var message: String {
            switch self {
            case .nilRecognizer: return "Can't initialize speech recognizer"
            case .notAuthorizedToRecognize: return "Not authorized to recognize speech"
            case .notPermittedToRecord: return "Not permitted to record audio"
            case .recognizerIsUnavailable: return "Recognizer is unavailable"
            }
        }
    }
    
}
