//
//  VoicifySTTProvider.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/26/22.
//

public class VoicifySTTProvider : VoicifySpeechToTextProvider
{
    private var speechStartHandlers: Array<() -> Void> = []
    private var speechReadyHandlers: Array<() -> Void> = []
    private var speechPartialHandlers: Array<() -> Void> = []
    private var speechEndHandlers: Array<() -> Void> = []
    private var speechResultHandlers: Array<() -> Void> = []
    private var speechErrorHandler: Array<() -> Void> = []
    private var speechVolumeHandler: Array<() -> Void> = []
    private var locale: String = ""
    
    public func initialize(locale: String) {
        self.locale = locale
    }
    
    public func addPartialListener(callback: (String) -> Void) {
        <#code#>
    }
    
    public func addFinalResultListener(callback: (String) -> Void) {
        <#code#>
    }
    
    public func addErrorListener(callback: (String) -> Void) {
        <#code#>
    }
    
    public func startListening() {
        <#code#>
    }
    
    public func stopListening() {
        <#code#>
    }
    
}
