//
//  CustomAssistantConfigurationService.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 1/26/23.
//

import UIKit

public class CustomAssistantConfigurationService
{
    public var customAssistantConfiguration: CustomAssistantConfigurationResponse? = nil
        
    public func getCustomAssistantConfiguration(configurationId: String? = "", serverRootUrl: String, appId: String, appKey: String) async throws -> CustomAssistantConfigurationResponse{
        if let configId = configurationId {
            guard let getConfigurationURL = URL(string: "\(serverRootUrl)/api/CustomAssistantConfiguration/\(configId)/Swift?applicationId=\(appId)&applicationSecret=\(appKey)") else { fatalError("Missing URL") }
            let customAssistantRequest = generateGetRequest(url: getConfigurationURL)
            let session = URLSession.shared
            let (data, response) = try await session.data(for: customAssistantRequest)
            guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200
            else {
                throw ResponseError.Invalid
            }
            if(!data.isEmpty)
            {
                let decoder = JSONDecoder()
                let configurationResponse = try decoder.decode(CustomAssistantConfigurationResponse.self, from: data)
                return configurationResponse
            }
            else{
                throw ResponseError.Invalid
            }
        }
        else{
            throw ResponseError.Invalid
        }
        
    }
    enum ResponseError: Error {
            case Invalid
    }
    
    func mapSettingsProps(configuration: CustomAssistantConfigurationResponse, configurationSettingsProps: ConfigurationSettingsProps, assistantSettingsProps: AssistantSettingsProps){
        if let autoRunConversation = configuration.autoRunConversation {
            configurationSettingsProps.autoRunConversation = autoRunConversation
        }
        if let useVoiceInput = configuration.useVoiceInput {
            configurationSettingsProps.autoRunConversation = useVoiceInput
        }
        if let noTracking = configuration.noTracking {
            configurationSettingsProps.noTracking = noTracking
        }
        if let useOutputSpeech = configuration.useOutputSpeech {
            configurationSettingsProps.useOutputSpeech = useOutputSpeech
        }
        if let useDraftContent = configuration.useDraftContent {
            configurationSettingsProps.useDraftContent = useDraftContent
        }
        if let initializeWithWelcomeMessage = configuration.initializeWithWelcomeMessage {
            configurationSettingsProps.initializeWithWelcomeMessage = initializeWithWelcomeMessage
        }
        if let device = configuration.device {
            configurationSettingsProps.device = device
        }
        if let channel = configuration.channel {
            configurationSettingsProps.channel = channel
        }
        if let locale = configuration.locale {
            configurationSettingsProps.locale = locale
        }
        if let textToSpeechProvider = configuration.textToSpeechProvider {
            configurationSettingsProps.textToSpeechProvider = textToSpeechProvider
        }
        if let textToSpeechVoice = configuration.textToSpeechVoice {
            configurationSettingsProps.textToSpeechVoice = textToSpeechVoice
        }
        if let activeInput = configuration.activeInput{
            configurationSettingsProps.initializeWithText = (activeInput == "textbox")
        }
        if let backgroundColor = configuration.styles?.assistant.backgroundColor {
            configurationSettingsProps.backgroundColor = backgroundColor
        }
        configurationSettingsProps.appId = assistantSettingsProps.appId
        configurationSettingsProps.appKey = assistantSettingsProps.appKey
        configurationSettingsProps.serverRootUrl = assistantSettingsProps.serverRootUrl
    }
    
    func mapHeaderProps(configuration: CustomAssistantConfigurationResponse, configurationHeaderProps: ConfigurationHeaderProps){
        if let backgroundColor = configuration.styles?.header.backgroundColor{
            configurationHeaderProps.backgroundColor = backgroundColor
        }
        if let assistantName = configuration.styles?.header.assistantName{
            configurationHeaderProps.assistantName = assistantName
        }
        if let assistantNameTextColor = configuration.styles?.header.assistantNameTextColor{
            configurationHeaderProps.assistantNameTextColor = assistantNameTextColor
        }
        if let assistantImage = configuration.styles?.header.assistantImage{
            configurationHeaderProps.assistantImage = assistantImage
        }
        if let assistantImageBackgroundColor = configuration.styles?.header.assistantImageBackgroundColor{
            configurationHeaderProps.assistantImageBackgroundColor = assistantImageBackgroundColor
        }
        if let assistantImageBorderRadius = configuration.styles?.header.assistantImageBorderRadius{
            configurationHeaderProps.assistantImageBorderRadius = assistantImageBorderRadius
        }
        if let assistantImageBorderColor = configuration.styles?.header.assistantImageBorderColor{
            configurationHeaderProps.assistantImageBorderColor = assistantImageBorderColor
        }
        if let assistantImageBorderWidth = configuration.styles?.header.assistantImageBorderWidth{
            configurationHeaderProps.assistantImageBorderWidth = assistantImageBorderWidth
        }
        if let assistantImageColor = configuration.styles?.header.assistantImageColor{
            configurationHeaderProps.assistantImageColor = assistantImageColor
        }
        if let assistantImageHeight = configuration.styles?.header.assistantImageHeight{
            configurationHeaderProps.assistantImageHeight = assistantImageHeight
        }
        if let assistantImageWidth = configuration.styles?.header.assistantImageWidth{
            configurationHeaderProps.assistantImageWidth = assistantImageWidth
        }
        if let closeAssistantButtonBackgroundColor = configuration.styles?.header.closeAssistantButtonBackgroundColor{
            configurationHeaderProps.closeAssistantButtonBackgroundColor = closeAssistantButtonBackgroundColor
        }
        if let closeAssistantButtonBorderColor = configuration.styles?.header.closeAssistantButtonBorderColor{
            configurationHeaderProps.closeAssistantButtonBorderColor = closeAssistantButtonBorderColor
        }
        if let closeAssistantButtonBorderRadius = configuration.styles?.header.closeAssistantButtonBorderRadius{
            configurationHeaderProps.closeAssistantButtonBorderRadius = closeAssistantButtonBorderRadius
        }
        if let closeAssistantButtonBorderWidth = configuration.styles?.header.closeAssistantButtonBorderWidth{
            configurationHeaderProps.closeAssistantButtonBorderWidth = closeAssistantButtonBorderWidth
        }
        if let closeAssistantButtonImage = configuration.styles?.header.closeAssistantButtonImage{
            configurationHeaderProps.closeAssistantButtonImage = closeAssistantButtonImage
        }
        if let closeAssistantButtonImageHeight = configuration.styles?.header.closeAssistantButtonImageHeight{
            configurationHeaderProps.closeAssistantButtonImageHeight = closeAssistantButtonImageHeight
        }
        if let closeAssistantButtonImageWidth = configuration.styles?.header.closeAssistantButtonImageWidth{
            configurationHeaderProps.closeAssistantButtonImageWidth = closeAssistantButtonImageWidth
        }
        if let closeAssistantColor = configuration.styles?.header.closeAssistantColor{
            configurationHeaderProps.closeAssistantColor = closeAssistantColor
        }
        if let fontFamily = configuration.styles?.header.fontFamily{
            configurationHeaderProps.fontFamily = fontFamily
        }
        if let fontSize = configuration.styles?.header.fontSize{
            configurationHeaderProps.fontSize = fontSize
        }
        if let paddingBottom = configuration.styles?.header.paddingBottom{
            configurationHeaderProps.paddingBottom = paddingBottom
        }
        if let paddingLeft = configuration.styles?.header.paddingLeft{
            configurationHeaderProps.paddingLeft = paddingLeft
        }
        if let paddingRight = configuration.styles?.header.paddingRight{
            configurationHeaderProps.paddingRight = paddingRight
        }
        if let paddingTop = configuration.styles?.header.paddingTop{
            configurationHeaderProps.paddingTop = paddingTop
        }
    }
    
    func mapBodyProps(configuration: CustomAssistantConfigurationResponse, configurationBodyProps: ConfigurationBodyProps){
        if let backgroundColor = configuration.styles?.body.backgroundColor{
            configurationBodyProps.backgroundColor = backgroundColor
        }
        if let assistantImage = configuration.styles?.body.assistantImage{
            configurationBodyProps.assistantImage = assistantImage
        }
        if let paddingTop = configuration.styles?.body.paddingTop{
            configurationBodyProps.paddingTop = paddingTop
        }
        if let paddingRight = configuration.styles?.body.paddingRight{
            configurationBodyProps.paddingRight = paddingRight
        }
        if let paddingLeft = configuration.styles?.body.paddingLeft{
            configurationBodyProps.paddingLeft = paddingLeft
        }
        if let paddingBottom = configuration.styles?.body.paddingBottom{
            configurationBodyProps.paddingBottom = paddingBottom
        }
        if let assistantImageWidth = configuration.styles?.body.assistantImageWidth{
            configurationBodyProps.assistantImageWidth = assistantImageWidth
        }
        if let assistantImageHeight = configuration.styles?.body.assistantImageHeight{
            configurationBodyProps.assistantImageHeight = assistantImageHeight
        }
        if let assistantImageColor = configuration.styles?.body.assistantImageColor{
            configurationBodyProps.assistantImageColor = assistantImageColor
        }
        if let assistantImageBorderWidth = configuration.styles?.body.assistantImageBorderWidth{
            configurationBodyProps.assistantImageBorderWidth = assistantImageBorderWidth
        }
        if let assistantImageBorderColor = configuration.styles?.body.assistantImageBorderColor{
            configurationBodyProps.assistantImageBorderColor = assistantImageBorderColor
        }
        if let assistantImageBorderRadius = configuration.styles?.body.assistantImageBorderRadius{
            configurationBodyProps.assistantImageBorderRadius = assistantImageBorderRadius
        }
        if let assistantImageBackgroundColor = configuration.styles?.body.assistantImageBackgroundColor{
            configurationBodyProps.assistantImageBackgroundColor = assistantImageBackgroundColor
        }
        if let borderBottomColor = configuration.styles?.body.borderBottomColor{
            configurationBodyProps.borderBottomColor = borderBottomColor
        }
        if let borderBottomWidth = configuration.styles?.body.borderBottomWidth{
            configurationBodyProps.borderBottomWidth = borderBottomWidth
        }
        if let borderTopColor = configuration.styles?.body.borderTopColor{
            configurationBodyProps.borderTopColor = borderTopColor
        }
        if let borderTopWidth = configuration.styles?.body.borderTopWidth{
            configurationBodyProps.borderTopWidth = borderTopWidth
        }
        if let hintsBackgroundColor = configuration.styles?.body.hintsBackgroundColor{
            configurationBodyProps.hintsBackgroundColor = hintsBackgroundColor
        }
        if let hintsBorderColor = configuration.styles?.body.hintsBorderColor{
            configurationBodyProps.hintsBorderColor = hintsBorderColor
        }
        if let hintsBorderRadius = configuration.styles?.body.hintsBorderRadius{
            configurationBodyProps.hintsBorderRadius = hintsBorderRadius
        }
        if let hintsBorderWidth = configuration.styles?.body.hintsBorderWidth{
            configurationBodyProps.hintsBorderWidth = hintsBorderWidth
        }
        if let hintsFontFamily = configuration.styles?.body.hintsFontFamily{
            configurationBodyProps.hintsFontFamily = hintsFontFamily
        }
        if let hintsFontSize = configuration.styles?.body.hintsFontSize{
            configurationBodyProps.hintsFontSize = hintsFontSize
        }
        if let hintsPaddingBottom = configuration.styles?.body.hintsPaddingBottom{
            configurationBodyProps.hintsPaddingBottom = hintsPaddingBottom
        }
        if let hintsPaddingLeft = configuration.styles?.body.hintsPaddingLeft{
            configurationBodyProps.hintsPaddingLeft = hintsPaddingLeft
        }
        if let hintsPaddingRight = configuration.styles?.body.hintsPaddingRight{
            configurationBodyProps.hintsPaddingRight = hintsPaddingRight
        }
        if let hintsPaddingTop = configuration.styles?.body.hintsPaddingTop{
            configurationBodyProps.hintsPaddingTop = hintsPaddingTop
        }
        if let hintsTextColor = configuration.styles?.body.hintsTextColor{
            configurationBodyProps.hintsTextColor = hintsTextColor
        }
        if let messageReceivedBackgroundColor = configuration.styles?.body.messageReceivedBackgroundColor{
            configurationBodyProps.messageReceivedBackgroundColor = messageReceivedBackgroundColor
        }
        if let messageReceivedBorderBottomLeftRadius = configuration.styles?.body.messageReceivedBorderBottomLeftRadius{
            configurationBodyProps.messageReceivedBorderBottomLeftRadius = messageReceivedBorderBottomLeftRadius
        }
        if let messageReceivedBorderBottomRightRadius = configuration.styles?.body.messageReceivedBorderBottomRightRadius{
            configurationBodyProps.messageReceivedBorderBottomRightRadius = messageReceivedBorderBottomRightRadius
        }
        if let messageReceivedBorderColor = configuration.styles?.body.messageReceivedBorderColor{
            configurationBodyProps.messageReceivedBorderColor = messageReceivedBorderColor
        }
        if let messageReceivedBorderTopLeftRadius = configuration.styles?.body.messageReceivedBorderTopLeftRadius{
            configurationBodyProps.messageReceivedBorderTopLeftRadius = messageReceivedBorderTopLeftRadius
        }
        if let messageReceivedBorderTopRightRadius = configuration.styles?.body.messageReceivedBorderTopRightRadius{
            configurationBodyProps.messageReceivedBorderTopRightRadius = messageReceivedBorderTopRightRadius
        }
        if let messageReceivedBorderWidth = configuration.styles?.body.messageReceivedBorderWidth{
            configurationBodyProps.messageReceivedBorderWidth = messageReceivedBorderWidth
        }
        if let messageReceivedFontFamily = configuration.styles?.body.messageReceivedFontFamily{
            configurationBodyProps.messageReceivedFontFamily = messageReceivedFontFamily
        }
        if let messageReceivedFontSize = configuration.styles?.body.messageReceivedFontSize{
            configurationBodyProps.messageReceivedFontSize = messageReceivedFontSize
        }
        if let messageReceivedTextColor = configuration.styles?.body.messageReceivedTextColor{
            configurationBodyProps.messageReceivedTextColor = messageReceivedTextColor
        }
        if let messageSentBackgroundColor = configuration.styles?.body.messageSentBackgroundColor{
            configurationBodyProps.messageSentBackgroundColor = messageSentBackgroundColor
        }
        if let messageSentBorderBottomLeftRadius = configuration.styles?.body.messageSentBorderBottomLeftRadius{
            configurationBodyProps.messageSentBorderBottomLeftRadius = messageSentBorderBottomLeftRadius
        }
        if let messageSentBorderBottomRightRadius = configuration.styles?.body.messageSentBorderBottomRightRadius{
            configurationBodyProps.messageSentBorderBottomRightRadius = messageSentBorderBottomRightRadius
        }
        if let messageSentBorderColor = configuration.styles?.body.messageSentBorderColor{
            configurationBodyProps.messageSentBorderColor = messageSentBorderColor
        }
        if let messageSentBorderTopLeftRadius = configuration.styles?.body.messageSentBorderTopLeftRadius{
            configurationBodyProps.messageSentBorderTopLeftRadius = messageSentBorderTopLeftRadius
        }
        if let messageSentBorderTopRightRadius = configuration.styles?.body.messageSentBorderTopRightRadius{
            configurationBodyProps.messageSentBorderTopRightRadius = messageSentBorderTopRightRadius
        }
        if let messageSentBorderWidth = configuration.styles?.body.messageSentBorderWidth{
            configurationBodyProps.messageSentBorderWidth = messageSentBorderWidth
        }
        if let messageSentFontFamily = configuration.styles?.body.messageSentFontFamily{
            configurationBodyProps.messageSentFontFamily = messageSentFontFamily
        }
        if let messageSentFontSize = configuration.styles?.body.messageSentFontSize{
            configurationBodyProps.messageSentFontSize = messageSentFontSize
        }
        if let messageSentTextColor = configuration.styles?.body.messageSentTextColor{
            configurationBodyProps.messageSentTextColor = messageSentTextColor
        }
    }
    
    func mapToolbarProps(configuration: CustomAssistantConfigurationResponse, configurationToolbarProps: ConfigurationToolbarProps){
        if let backgroundColor = configuration.styles?.toolbar.backgroundColor{
            configurationToolbarProps.backgroundColor = backgroundColor
        }
        if let paddingBottom = configuration.styles?.toolbar.paddingBottom{
            configurationToolbarProps.paddingBottom = paddingBottom
        }
        if let paddingLeft = configuration.styles?.toolbar.paddingLeft{
            configurationToolbarProps.paddingLeft = paddingLeft
        }
        if let paddingRight = configuration.styles?.toolbar.paddingRight{
            configurationToolbarProps.paddingRight = paddingRight
        }
        if let paddingTop = configuration.styles?.toolbar.paddingTop{
            configurationToolbarProps.paddingTop = paddingTop
        }
        if let assistantStateFontFamily = configuration.styles?.toolbar.assistantStateFontFamily{
            configurationToolbarProps.assistantStateFontFamily = assistantStateFontFamily
        }
        if let assistantStateFontSize = configuration.styles?.toolbar.assistantStateFontSize{
            configurationToolbarProps.assistantStateFontSize = assistantStateFontSize
        }
        if let assistantStateTextColor = configuration.styles?.toolbar.assistantStateTextColor{
            configurationToolbarProps.assistantStateTextColor = assistantStateTextColor
        }
        if let drawerSpeechHeight = configuration.styles?.toolbar.drawerSpeechHeight{
            configurationToolbarProps.drawerSpeechHeight = drawerSpeechHeight
        }
        if let drawerTextHeight = configuration.styles?.toolbar.drawerTextHeight{
            configurationToolbarProps.drawerTextHeight = drawerTextHeight
        }
        if let equalizerColor = configuration.styles?.toolbar.equalizerColor{
            configurationToolbarProps.equalizerColor = equalizerColor
        }
        if let fullSpeechResultTextColor = configuration.styles?.toolbar.fullSpeechResultTextColor{
            configurationToolbarProps.fullSpeechResultTextColor = fullSpeechResultTextColor
        }
        if let helpText = configuration.styles?.toolbar.helpText{
            configurationToolbarProps.helpText = helpText
        }
        if let helpTextFontColor = configuration.styles?.toolbar.helpTextFontColor{
            configurationToolbarProps.helpTextFontColor = helpTextFontColor
        }
        if let helpTextFontFamily = configuration.styles?.toolbar.helpTextFontFamily{
            configurationToolbarProps.helpTextFontFamily = helpTextFontFamily
        }
        if let helpTextFontSize = configuration.styles?.toolbar.helpTextFontSize{
            configurationToolbarProps.helpTextFontSize = helpTextFontSize
        }
        if let micActiveColor = configuration.styles?.toolbar.micActiveColor{
            configurationToolbarProps.micActiveColor = micActiveColor
        }
        if let micActiveHighlightColor = configuration.styles?.toolbar.micActiveHighlightColor{
            configurationToolbarProps.micActiveHighlightColor = micActiveHighlightColor
        }
        if let micActiveImage = configuration.styles?.toolbar.micActiveImage{
            configurationToolbarProps.micActiveImage = micActiveImage
        }
        if let micBorderRadius = configuration.styles?.toolbar.micBorderRadius{
            configurationToolbarProps.micBorderRadius = micBorderRadius
        }
        if let micImageBorderColor = configuration.styles?.toolbar.micImageBorderColor{
            configurationToolbarProps.micImageBorderColor = micImageBorderColor
        }
        if let micImageBorderWidth = configuration.styles?.toolbar.micImageBorderWidth{
            configurationToolbarProps.micImageBorderWidth = micImageBorderWidth
        }
        if let micImageHeight = configuration.styles?.toolbar.micImageHeight{
            configurationToolbarProps.micImageHeight = micImageHeight
        }
        if let micImagePadding = configuration.styles?.toolbar.micImagePadding{
            configurationToolbarProps.micImagePadding = micImagePadding
        }
        if let micImageWidth = configuration.styles?.toolbar.micImageWidth{
            configurationToolbarProps.micImageWidth = micImageWidth
        }
        if let micInactiveColor = configuration.styles?.toolbar.micInactiveColor{
            configurationToolbarProps.micInactiveColor = micInactiveColor
        }
        if let micInactiveHighlightColor = configuration.styles?.toolbar.micInactiveHighlightColor{
            configurationToolbarProps.micInactiveHighlightColor = micInactiveHighlightColor
        }
        if let partialSpeechResultFontFamily = configuration.styles?.toolbar.partialSpeechResultFontFamily{
            configurationToolbarProps.partialSpeechResultFontFamily = partialSpeechResultFontFamily
        }
        if let partialSpeechResultTextColor = configuration.styles?.toolbar.partialSpeechResultTextColor{
            configurationToolbarProps.partialSpeechResultTextColor = partialSpeechResultTextColor
        }
        if let micInactiveImage = configuration.styles?.toolbar.micInactiveImage{
            configurationToolbarProps.micInactiveImage = micInactiveImage
        }
        if let partialSpeechResultFontSize = configuration.styles?.toolbar.partialSpeechResultFontSize{
            configurationToolbarProps.partialSpeechResultFontSize = partialSpeechResultFontSize
        }
        if let placeholder = configuration.styles?.toolbar.placeholder{
            configurationToolbarProps.placeholder = placeholder
        }
        if let sendActiveColor = configuration.styles?.toolbar.sendActiveColor{
            configurationToolbarProps.sendActiveColor = sendActiveColor
        }
        if let sendActiveImage = configuration.styles?.toolbar.sendActiveImage{
            configurationToolbarProps.sendActiveImage = sendActiveImage
        }
        if let sendImageHeight = configuration.styles?.toolbar.sendImageHeight{
            configurationToolbarProps.sendImageHeight = sendImageHeight
        }
        if let sendImageWidth = configuration.styles?.toolbar.sendImageWidth{
            configurationToolbarProps.sendImageWidth = sendImageWidth
        }
        if let sendInactiveColor = configuration.styles?.toolbar.sendInactiveColor{
            configurationToolbarProps.sendInactiveColor = sendInactiveColor
        }
        if let sendInactiveImage = configuration.styles?.toolbar.sendInactiveImage{
            configurationToolbarProps.sendInactiveImage = sendInactiveImage
        }
        if let speakActiveTitleColor = configuration.styles?.toolbar.speakActiveTitleColor{
            configurationToolbarProps.speakActiveTitleColor = speakActiveTitleColor
        }
        if let speakFontFamily = configuration.styles?.toolbar.speakFontFamily{
            configurationToolbarProps.speakFontFamily = speakFontFamily
        }
        if let speakFontSize = configuration.styles?.toolbar.speakFontSize{
            configurationToolbarProps.speakFontSize = speakFontSize
        }
        if let speakInactiveTitleColor = configuration.styles?.toolbar.speakInactiveTitleColor{
            configurationToolbarProps.speakInactiveTitleColor = speakInactiveTitleColor
        }
        if let speechResultBoxBackgroundColor = configuration.styles?.toolbar.speechResultBoxBackgroundColor{
            configurationToolbarProps.speechResultBoxBackgroundColor = speechResultBoxBackgroundColor
        }
        if let textInputActiveLineColor = configuration.styles?.toolbar.textInputActiveLineColor{
            configurationToolbarProps.textInputActiveLineColor = textInputActiveLineColor
        }
        if let textInputCursorColor = configuration.styles?.toolbar.textInputCursorColor{
            configurationToolbarProps.textInputCursorColor = textInputCursorColor
        }
        if let textInputLineColor = configuration.styles?.toolbar.textInputLineColor{
            configurationToolbarProps.textInputLineColor = textInputLineColor
        }
        if let textboxActiveHighlightColor = configuration.styles?.toolbar.textboxActiveHighlightColor{
            configurationToolbarProps.textboxActiveHighlightColor = textboxActiveHighlightColor
        }
        if let textInputTextColor = configuration.styles?.toolbar.textInputTextColor{
            configurationToolbarProps.textInputTextColor = textInputTextColor
        }
        if let textboxFontFamily = configuration.styles?.toolbar.textboxFontFamily{
            configurationToolbarProps.textboxFontFamily = textboxFontFamily
        }
        if let textboxFontSize = configuration.styles?.toolbar.textboxFontSize{
            configurationToolbarProps.textboxFontSize = textboxFontSize
        }
        if let textboxInactiveHighlightColor = configuration.styles?.toolbar.textboxInactiveHighlightColor{
            configurationToolbarProps.textboxInactiveHighlightColor = textboxInactiveHighlightColor
        }
        if let typeActiveTitleColor = configuration.styles?.toolbar.typeActiveTitleColor{
            configurationToolbarProps.typeActiveTitleColor = typeActiveTitleColor
        }
        if let typeFontSize = configuration.styles?.toolbar.typeFontSize{
            configurationToolbarProps.typeFontSize = typeFontSize
        }
        if let typeFontFamily = configuration.styles?.toolbar.typeFontFamily{
            configurationToolbarProps.typeFontFamily = typeFontFamily
        }
        if let typeInactiveTitleColor = configuration.styles?.toolbar.typeInactiveTitleColor{
            configurationToolbarProps.typeInactiveTitleColor = typeInactiveTitleColor
        }
    }

    func generateGetRequest(url: URL) -> URLRequest{
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}


