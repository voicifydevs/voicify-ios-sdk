//
//  AssistantSettingsProps.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 11/3/22.
//

import UIKit
import SwiftUI

public class AssistantSettingsProps
{
    public var configurationId: String? = nil
    public var serverRootUrl: String
    public var appId: String
    public var appKey: String
    public var locale: String? = nil
    public var textToSpeechVoice: String? = nil
    public var channel: String? = nil
    public var device: String? = nil
    public var autoRunConversation: Bool? = nil
    public var initializeWithWelcomeMessage: Bool? = nil
    public var textToSpeechProvider: String? = nil
    public var useVoiceInput: Bool? = nil
    public var useOutputSpeech: Bool? = nil
    public var useDraftContent: Bool? = nil
    public var noTracking: Bool? = nil
    public var initializeWithText: Bool? = nil
    public var backgroundColor: String? = nil
    public var effects: Array<String>? = nil
    public var onEffect: ((String, Dictionary<String, Any>) -> Void)? = nil
    public var onAssistantClose: (() -> Void)? = nil
    public var onAssistantError: ((String, CustomAssistantRequest) -> Void)? = nil
    public var sessionAttributes: Dictionary<String, String>? = nil
    public var userAttributes: Dictionary<String, String>? = nil
    public var sessionFlags: Array<String>? = nil
    
    public init(configurationId: String? = nil, serverRootUrl: String, appId: String, appKey: String, locale: String? = nil, channel: String? = nil, device: String? = nil, textToSpeechVoice: String? = nil, autoRunConversation: Bool? = nil, initializeWithWelcomeMessage: Bool? = nil, textToSpeechProvider: String? = nil, useVoiceInput: Bool? = nil, useOutputSpeech: Bool? = nil, useDraftContent: Bool? = nil, noTracking: Bool? = nil, initializeWithText: Bool? = nil, backgroundColor: String? = nil, effects: Array<String>? = nil, onEffect: ((String, Dictionary<String, Any>) -> Void)? = nil, onAssistantClose: (() -> Void)? = nil, onAssistantError: ((String, CustomAssistantRequest) -> Void)? = nil, sessionAttributes: Dictionary<String, String>? = nil, userAttributes: Dictionary<String, String>? = nil, sessionFlags: Array<String>? = nil) {
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
        self.sessionFlags = sessionFlags
    }
}
