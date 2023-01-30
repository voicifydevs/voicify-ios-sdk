//
//  ConfigurationSettingsProps.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 1/27/23.
//

//
//  AssistantSettingsProps.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 11/3/22.
//

import UIKit
import SwiftUI

public class ConfigurationSettingsProps: ObservableObject
{
    @Published public var configurationId: String? = nil
    @Published public var serverRootUrl: String
    @Published public var appId: String
    @Published public var appKey: String
    @Published public var locale: String? = nil
    @Published public var textToSpeechVoice: String? = nil
    @Published public var channel: String? = nil
    @Published public var device: String? = nil
    @Published public var autoRunConversation: Bool? = nil
    @Published public var initializeWithWelcomeMessage: Bool? = nil
    @Published public var textToSpeechProvider: String? = nil
    @Published public var useVoiceInput: Bool? = nil
    @Published public var useOutputSpeech: Bool? = nil
    @Published public var useDraftContent: Bool? = nil
    @Published public var noTracking: Bool? = nil
    @Published public var initializeWithText: Bool? = nil
    @Published public var backgroundColor: String? = nil
    @Published public var effects: Array<String>? = nil
    @Published public var onEffect: ((String, Dictionary<String, Any>) -> Void)? = nil
    @Published public var onAssistantClose: (() -> Void)? = nil
    @Published public var onAssistantError: ((String, CustomAssistantRequest) -> Void)? = nil
    @Published public var sessionAttributes: Dictionary<String, Any>? = nil
    @Published public var userAttributes: Dictionary<String, Any>? = nil
    
    public init(configurationId: String? = nil, serverRootUrl: String, appId: String, appKey: String, locale: String? = nil, channel: String? = nil, device: String? = nil, textToSpeechVoice: String? = nil, autoRunConversation: Bool? = nil, initializeWithWelcomeMessage: Bool? = nil, textToSpeechProvider: String? = nil, useVoiceInput: Bool? = nil, useOutputSpeech: Bool? = nil, useDraftContent: Bool? = nil, noTracking: Bool? = nil, initializeWithText: Bool? = nil, backgroundColor: String? = nil, effects: Array<String>? = nil, onEffect: ((String, Dictionary<String, Any>) -> Void)? = nil, onAssistantClose: (() -> Void)? = nil, onAssistantError: ((String, CustomAssistantRequest) -> Void)? = nil, sessionAttributes: Dictionary<String, Any>? = nil, userAttributes: Dictionary<String, Any>? = nil) {
        self.configurationId = configurationId
        self.serverRootUrl = serverRootUrl
        self.appId = appId
        self.appKey = appKey
        self.locale = locale
        self.channel = channel
        self.textToSpeechVoice = textToSpeechVoice
        self.device = device
        self.autoRunConversation = autoRunConversation
        self.initializeWithWelcomeMessage = initializeWithWelcomeMessage
        self.textToSpeechProvider = textToSpeechProvider
        self.useVoiceInput = useVoiceInput
        self.useOutputSpeech = useOutputSpeech
        self.useDraftContent = useDraftContent
        self.noTracking = noTracking
        self.initializeWithText = initializeWithText
        self.backgroundColor = backgroundColor
        self.effects = effects
        self.onEffect = onEffect
        self.onAssistantClose = onAssistantClose
        self.onAssistantError = onAssistantError
        self.sessionAttributes = sessionAttributes
        self.userAttributes = userAttributes
    }
}

