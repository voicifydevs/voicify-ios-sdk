//
//  CustomAssistantConfigurationResponse.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 1/26/23.
//

public class CustomAssistantConfigurationResponse: Codable
{
    public var id: String? = nil
    public var applicationId: String? = nil
    public var applicationSecret: String? = nil
    public var environmentId: String? = nil
    public var textToSpeechProvider: String? = nil
    public var locale: String? = nil
    public var textToSpeechVoice: String? = nil
    public var channel: String? = nil
    public var device: String? = nil
    public var name: String? = nil
    public var autoRunConversation: Bool? = nil
    public var initializeWithWelcomeMessage: Bool? = nil
    public var useOutputSpeech: Bool? = nil
    public var useVoiceInput: Bool? = nil
    public var sessionTimeout: Int? = nil
    public var uiType: String? = nil
    public var noTracking: Bool? = nil
    public var useDraftContent: Bool? = nil
    public var activeInput: String? = nil
    public var avatarUrl: String? = nil
    public var displayName: String? = nil
    public var theme: String? = nil
    public var styles: ConfigurationStyles? = nil
    
    public init(id: String, applicationId: String, applicationSecret: String, environmentId: String? = nil, textToSpeechProvider: String? = nil, locale: String? = nil, textToSpeechVoice: String? = nil, channel: String? = nil, device: String? = nil, name: String? = nil, autoRunConversation: Bool? = nil, initializeWithWelcomeMessage: Bool? = nil, useOutputSpeech: Bool? = nil, useVoiceInput: Bool? = nil, sessionTimeout: Int? = nil, uiType: String? = nil, noTracking: Bool? = nil, useDraftContent: Bool? = nil, activeInput: String? = nil, avatarUrl: String? = nil, displayName: String? = nil, theme: String? = nil, styles: ConfigurationStyles? = nil) {
        self.id = id
        self.applicationId = applicationId
        self.applicationSecret = applicationSecret
        self.environmentId = environmentId
        self.textToSpeechProvider = textToSpeechProvider
        self.locale = locale
        self.textToSpeechVoice = textToSpeechVoice
        self.channel = channel
        self.device = device
        self.name = name
        self.autoRunConversation = autoRunConversation
        self.initializeWithWelcomeMessage = initializeWithWelcomeMessage
        self.useOutputSpeech = useOutputSpeech
        self.useVoiceInput = useVoiceInput
        self.sessionTimeout = sessionTimeout
        self.uiType = uiType
        self.noTracking = noTracking
        self.useDraftContent = useDraftContent
        self.activeInput = activeInput
        self.avatarUrl = avatarUrl
        self.displayName = displayName
        self.theme = theme
        self.styles = styles
    }
}

