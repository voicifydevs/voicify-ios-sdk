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
    public var onEffect: (String, Dictionary<String, Any>) -> Void
    public var sessionAttributes: Dictionary<String, Any>? = nil
    public var userAttributes: Dictionary<String, Any>? = nil
    
    public init(serverRootUrl: String, appId: String, appKey: String, locale: String, channel: String, device: String, voice: String, autoRunConversation: Bool, initializeWithWelcomeMessage: Bool, textToSpeechProvider: String, useVoiceInput: Bool, useOutputSpeech: Bool, initializeWithText: Bool, useDraftContent: Bool, noTracking: Bool, effects: Array<String>, onEffect: @escaping (String, Dictionary<String, Any>) -> Void, sessionAttributes: Dictionary<String, Any>? = nil, userAttributes: Dictionary<String, Any>? = nil) {
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
        self.onEffect = onEffect
        self.sessionAttributes = sessionAttributes
        self.userAttributes = userAttributes
    }
}
