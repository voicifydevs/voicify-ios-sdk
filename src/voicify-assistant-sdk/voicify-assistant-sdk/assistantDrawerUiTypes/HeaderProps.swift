//
//  HeaderProps.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 12/6/22.
//

import Foundation

public class HeaderProps
{
    public var fontSize: Float? = nil
    public var backgroundColor: String? = nil
    public var assistantImage: String? = nil
    public var assistantImageColor: String? = nil
    public var assistantImageHeight: Int? = nil
    public var assistantImageWidth: Int? = nil
    public var assistantImageBackgroundColor: String? = nil
    public var assistantName: String? = nil
    public var assistantNameTextColor: String? = nil
    public var assistantImageBorderRadius: Float? = nil
    public var assistantImageBorderColor: String? = nil
    public var assistantImageBorderWidth: Int? = nil
    public var closeAssistantButtonImage: String? = nil
    public var closeAssistantColor: String? = nil
    public var closeAssistantButtonImageHeight: Int? = nil
    public var closeAssistantButtonImageWidth: Int? = nil
    public var closeAssistantButtonBorderRadius: Float? = nil
    public var closeAssistantButtonBackgroundColor: String? = nil
    public var closeAssistantButtonBorderWidth: Int? = nil
    public var closeAssistantButtonBorderColor: String? = nil
    public var paddingLeft: Int? = nil
    public var paddingRight: Int? = nil
    public var paddingTop: Int? = nil
    public var paddingBottom: Int? = nil
    public var fontFamily: String? = nil
    
    public init(fontSize: Float? = nil, backgroundColor: String? = nil, assistantImage: String? = nil, assistantImageColor: String? = nil, assistantImageBackgroundColor: String? = nil,  assistantImageHeight: Int? = nil, assistantImageWidth: Int? = nil, assistantName: String? = nil, assistantNameTextColor: String? = nil, assistantImageBorderRadius: Float? = nil, assistantImageBorderColor: String? = nil, assistantImageBorderWidth: Int? = nil, closeAssistantButtonImage: String? = nil, closeAssistantColor: String? = nil, closeAssistantButtonImageHeight: Int? = nil, closeAssistantButtonImageWidth: Int? = nil, closeAssistantButtonBorderRadius: Float? = nil, closeAssistantButtonBackgroundColor: String? = nil, closeAssistantButtonBorderWidth: Int? = nil, closeAssistantButtonBorderColor: String? = nil, paddingLeft: Int? = nil, paddingRight: Int? = nil, paddingTop: Int? = nil, paddingBottom: Int? = nil, fontFamily: String? = nil) {
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
        self.closeAssistantColor = closeAssistantColor
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
    }
}
