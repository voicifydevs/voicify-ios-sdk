//
//  AssistantSettingsProps.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 11/3/22.
//

import UIKit

public class AssistantSettingsProps : ObservableObject
{
    public var serverRootUrl: String
    public var appId: String
    public var appKey: String
    public var locale: String
    public var voice: String
    public var channel: String
    public var device: String
    public var autoRunConversation: Bool
    public var initializeWithWelcomeMessage: Bool
    public var textToSpeechProvider: String
    public var useVoiceInput: Bool
    public var useOutputSpeech: Bool
    public var initializeWithText: Bool
    public var useDraftContent: Bool
    public var noTracking: Bool
    public var effects: Array<String>
    public var assistantIsOpen: Bool
    
    public init(serverRootUrl: String, appId: String, appKey: String, locale: String, channel: String, device: String, voice: String, autoRunConversation: Bool, initializeWithWelcomeMessage: Bool, textToSpeechProvider: String, useVoiceInput: Bool, useOutputSpeech: Bool, initializeWithText: Bool, useDraftContent: Bool, noTracking: Bool, effects: Array<String>, assistantIsOpen: Bool) {
        self.serverRootUrl = serverRootUrl
        self.appId = appId
        self.appKey = appKey
        self.locale = locale
        self.channel = channel
        self.voice = voice
        self.device = device
        self.autoRunConversation = autoRunConversation
        self.initializeWithWelcomeMessage = initializeWithWelcomeMessage
        self.textToSpeechProvider = textToSpeechProvider
        self.useVoiceInput = useVoiceInput
        self.useOutputSpeech = useOutputSpeech
        self.initializeWithText = initializeWithText
        self.useDraftContent = useDraftContent
        self.noTracking = noTracking
        self.effects = effects
        self.assistantIsOpen = assistantIsOpen
    }
}