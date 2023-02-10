//
//  VoicifyAssistantSettings.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/26/22.
//

public class VoicifyAssistantSettings
{
    public var serverRootUrl: String
    public var appId: String
    public var appKey: String
    public var locale: String
    public var channel: String
    public var device: String
    public var autoRunConversation: Bool
    public var initializeWithWelcomeMessage: Bool
    public var initializeWithText: Bool
    public var useVoiceInput: Bool
    public var useDraftContent: Bool
    public var useOutputSpeech: Bool
    public var noTracking: Bool
    
    public init(serverRootUrl: String, appId: String, appKey: String, locale: String, channel: String, device: String, autoRunConversation: Bool, initializeWithWelcomeMessage: Bool, initializeWithText: Bool, useVoiceInput: Bool, useDraftContent: Bool, useOutputSpeech: Bool, noTracking: Bool) {
        self.serverRootUrl = serverRootUrl
        self.appId = appId
        self.appKey = appKey
        self.locale = locale
        self.channel = channel
        self.device = device
        self.autoRunConversation = autoRunConversation
        self.initializeWithWelcomeMessage = initializeWithWelcomeMessage
        self.initializeWithText = initializeWithText
        self.useVoiceInput = useVoiceInput
        self.useDraftContent = useDraftContent
        self.useOutputSpeech = useOutputSpeech
        self.noTracking = noTracking
    }
}
