//
//  ConfigurationHeaderPROPS.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 1/26/23.
//

public class ConfigurationHeaderProps : ObservableObject
{
    @Published public var fontSize: Float? = nil
    @Published public var backgroundColor: String? = nil
    @Published public var assistantImage: String? = nil
    @Published public var assistantImageColor: String? = nil
    @Published public var assistantImageHeight: Int? = nil
    @Published public var assistantImageWidth: Int? = nil
    @Published public var assistantImageBackgroundColor: String? = nil
    @Published public var assistantName: String? = nil
    @Published public var assistantNameTextColor: String? = nil
    @Published public var assistantImageBorderRadius: Float? = nil
    @Published public var assistantImageBorderColor: String? = nil
    @Published public var assistantImageBorderWidth: Int? = nil
    @Published public var closeAssistantButtonImage: String? = nil
    @Published public var closeAssistantButtonImageHeight: Int? = nil
    @Published public var closeAssistantButtonImageWidth: Int? = nil
    @Published public var closeAssistantButtonBorderRadius: Float? = nil
    @Published public var closeAssistantButtonBackgroundColor: String? = nil
    @Published public var closeAssistantButtonBorderWidth: Int? = nil
    @Published public var closeAssistantButtonBorderColor: String? = nil
    @Published public var paddingLeft: Int? = nil
    @Published public var paddingRight: Int? = nil
    @Published public var paddingTop: Int? = nil
    @Published public var paddingBottom: Int? = nil
    @Published public var fontFamily: String? = nil
    @Published public var closeAssistantColor: String? = nil
    
    public init(fontSize: Float? = nil, backgroundColor: String? = nil, assistantImage: String? = nil, assistantImageColor: String? = nil, assistantImageBackgroundColor: String? = nil,  assistantImageHeight: Int? = nil, assistantImageWidth: Int? = nil, assistantName: String? = nil, assistantNameTextColor: String? = nil, assistantImageBorderRadius: Float? = nil, assistantImageBorderColor: String? = nil, assistantImageBorderWidth: Int? = nil, closeAssistantButtonImage: String? = nil, closeAssistantButtonImageHeight: Int? = nil, closeAssistantButtonImageWidth: Int? = nil, closeAssistantButtonBorderRadius: Float? = nil, closeAssistantButtonBackgroundColor: String? = nil, closeAssistantButtonBorderWidth: Int? = nil, closeAssistantButtonBorderColor: String? = nil, paddingLeft: Int? = nil, paddingRight: Int? = nil, paddingTop: Int? = nil, paddingBottom: Int? = nil, fontFamily: String? = nil, closeAssistantColor: String? = nil) {
        self.fontSize = fontSize
        self.backgroundColor = backgroundColor
        self.assistantImage = assistantImage
        self.assistantImageColor = assistantImageColor
        self.assistantImageBackgroundColor = assistantImageBackgroundColor
        self.assistantImageHeight = assistantImageHeight
        self.assistantImageWidth = assistantImageWidth
        self.assistantName = assistantName
        self.assistantNameTextColor = assistantNameTextColor
        self.assistantImageBorderRadius = assistantImageBorderRadius
        self.assistantImageBorderColor = assistantImageBorderColor
        self.assistantImageBorderWidth = assistantImageBorderWidth
        self.closeAssistantButtonImage = closeAssistantButtonImage
        self.closeAssistantButtonImageHeight = closeAssistantButtonImageHeight
        self.closeAssistantButtonImageWidth = closeAssistantButtonImageWidth
        self.closeAssistantButtonBorderRadius = closeAssistantButtonBorderRadius
        self.closeAssistantButtonBackgroundColor = closeAssistantButtonBackgroundColor
        self.closeAssistantButtonBorderWidth = closeAssistantButtonBorderWidth
        self.closeAssistantButtonBorderColor = closeAssistantButtonBorderColor
        self.paddingLeft = paddingLeft
        self.paddingRight = paddingRight
        self.paddingTop = paddingTop
        self.paddingBottom = paddingBottom
        self.fontFamily = fontFamily
        self.closeAssistantColor = closeAssistantColor
    }
}
