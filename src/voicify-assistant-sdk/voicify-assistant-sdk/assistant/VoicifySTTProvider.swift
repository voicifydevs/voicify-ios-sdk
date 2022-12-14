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
import Accelerate

public class VoicifySTTProvider : VoicifySpeechToTextProvider, ObservableObject
{
    private var speechStartHandlers: Array<() -> Void> = []
    private var speechPartialHandlers: Array<(String) -> Void> = []
    private var speechEndHandlers: Array<() -> Void> = []
    private var speechResultHandlers: Array<(String) -> Void> = []
    private var speechErrorHandlers: Array<(String) -> Void> = []
    private var speechVolumeHandlers: Array<(Float) -> Void> = []
    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private var recognizer: SFSpeechRecognizer?
    private var speechTimeOut = Timer()
    public var cancel = false
    private var averagePowerForChannel0: Float = 0.0
    private var averagePowerForChannel1: Float = 0.0
    private var gotFullResult = false
    public var hasPermission = false
        
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
                hasPermission = true
            } catch {
                hasPermission = false
                speechErrorHandlers.forEach{ speechErrorHandler in
                    speechErrorHandler(error.localizedDescription)
                }
            }
        }
    }
    
    public func startListening() {
        if !cancel
        {
            gotFullResult = false
            self.speechStartHandlers.forEach{speechStart in
                speechStart()
            }
            self.speechTimeOut = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
                self.audioEngine?.stop()
                self.audioEngine?.inputNode.removeTap(onBus: 0)
                self.reset()
                self.speechEndHandlers.forEach{speechEndHandler in
                    speechEndHandler()
                }
            }
            DispatchQueue(label: "Speech Recognizer Queue", qos: .background).async { [weak self] in
                guard let self = self, let recognizer = self.recognizer, recognizer.isAvailable else {
                    self?.speechErrorHandlers.forEach{ errorHandler in
                        errorHandler(RecognizerError.recognizerIsUnavailable.message)
                    }
                    return
                }
                do {
                    let (audioEngine, request) = try self.prepareEngine()
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
        self.speechEndHandlers.forEach{speechEndHandler in
            speechEndHandler()
        }
    }
    
    private func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        let audioEngine = AVAudioEngine()
        
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        let audioSession = AVAudioSession.sharedInstance()
        
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            let inNumberFrames = buffer.frameLength
            let LEVEL_LOWPASS_TRIG: Float = 0.5
            if buffer.format.channelCount>0
            {
                let samples = buffer.floatChannelData?[0] as? UnsafeMutablePointer<Float32>
                var avgValue: Float32 = 0
                vDSP_maxmgv(samples!, 1, &avgValue, vDSP_Length(Float32(inNumberFrames)))
            
                let leftSide = LEVEL_LOWPASS_TRIG * (avgValue == 0 ? -100 : 20.0 * log10f(avgValue))
                let rightSide = (1 - LEVEL_LOWPASS_TRIG) * self.averagePowerForChannel0
                self.averagePowerForChannel0 = leftSide + rightSide
                self.averagePowerForChannel1 = self.averagePowerForChannel0
            }
            if buffer.format.channelCount > 1 {
                let samples = buffer.floatChannelData?[0] as? UnsafeMutablePointer<Float32>
                var avgValue: Float32 = 0
                vDSP_maxmgv(samples!, vDSP_Stride(1), &avgValue, vDSP_Length(inNumberFrames))
                let leftSide = (LEVEL_LOWPASS_TRIG * ((Int(avgValue) == 0) ? -100 : 20.0 * log10f(avgValue)))
                let rightSide = ((1 - LEVEL_LOWPASS_TRIG) * self.averagePowerForChannel1)
                self.averagePowerForChannel1 = leftSide + rightSide
            }
            let normalDb = self.normalizeDb(db: self.averagePowerForChannel0) * 10
            self.speechVolumeHandlers.forEach{volumeHandler in
                volumeHandler(normalDb)
            }
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
        if let result = result {
            if speechTimeOut.isValid
            {
                speechTimeOut.invalidate()
                speechTimeOut = Timer.scheduledTimer(withTimeInterval: 0.9, repeats: false) { timer in
                    self.audioEngine?.stop()
                    self.audioEngine?.inputNode.removeTap(onBus: 0)
                    self.speechResultHandlers.forEach{fullResultHandler in
                        fullResultHandler(result.bestTranscription.formattedString)
                    }
                    self.reset()
                    self.speechEndHandlers.forEach{speechEndHandler in
                        speechEndHandler()
                    }
                    self.gotFullResult = true
                }
            }
            else
            {
                speechTimeOut = Timer.scheduledTimer(withTimeInterval: 0.9, repeats: false) { timer in
                    self.audioEngine?.stop()
                    self.audioEngine?.inputNode.removeTap(onBus: 0)
                    self.speechResultHandlers.forEach{fullResultHandler in
                        fullResultHandler(result.bestTranscription.formattedString)
                    }
                    self.reset()
                    self.speechEndHandlers.forEach{speechEndHandler in
                        speechEndHandler()
                    }
                    self.gotFullResult = true
                    
                }
            }
            if(!gotFullResult)
            {
                self.speechPartialHandlers.forEach{ partialResultHandler in
                    partialResultHandler(result.bestTranscription.formattedString)
                }
            }
        }
        
    }
    
    private func normalizeDb (db: Float) -> Float{
        if (db < -80.0 || db == 0.0) {
                return 0.0
            }
        let power = powf((powf(10.0, 0.05 * db) - powf(10.0, 0.05 * -80.0)) * (1.0 / (1.0 - powf(10.0, 0.05 * -80.0))), 1.0 / 2.0)
        
        if (power < 1.0) {
               return power;
           }else{
               return 1.0;
           }
    }
    
    public func addStartListener(callback: @escaping () -> Void) {
        self.speechStartHandlers.append(callback)
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
    
    public func addVolumeListener(callback: @escaping(Float) -> Void){
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

extension SFSpeechRecognizer {
    static func hasAuthorizationToRecognize() async -> Bool {
        await withCheckedContinuation { continuation in
            requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
    }
}

extension AVAudioSession {
    func hasPermissionToRecord() async -> Bool {
        await withCheckedContinuation { continuation in
            requestRecordPermission { authorized in
                continuation.resume(returning: authorized)
            }
        }
    }
}
