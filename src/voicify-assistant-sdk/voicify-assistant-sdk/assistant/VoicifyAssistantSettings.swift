//
//  VoicifyAssistantSettings.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/26/22.
//

public class VoicifyAssistantSettings
{
    var serverRootUrl: String
    var appId: String
    var appKey: String
    var locale: String
    var channel: String
    var device: String
    var autoRunConversation: Bool
    var initializeWithWelcomeMessage: Bool
    var initializeWithText: Bool
    var useVoiceInput: Bool
    var useDraftContent: Bool
    var useOutputSpeech: Bool
    
    public init(serverRootUrl: String, appId: String, appKey: String, locale: String, channel: String, device: String, autoRunConversation: Bool, initializeWithWelcomeMessage: Bool, initializeWithText: Bool, useVoiceInput: Bool, useDraftContent: Bool, useOutputSpeech: Bool) {
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
    }
}
