//
//  HeaderProps.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 12/6/22.
//

import Foundation

public class HeaderProps
{
    public var fontSize: Float?
    public var backgroundColor: String?
    public var assistantImage: String?
    public var assistantImageBackgroundColor: String?
    public var assistantName: String?
    public var assistantNameTextColor: String
    public var assistantImageBorderRadius: Float?
    public var assistantImageBorderColor: String?
    public var assistantImageBorderWidth: Int?
    public var closeAssistantButtonImage: String?
    public var closeAssistantButtonBorderRadius: Float?
    public var closeAssistantButtonBackgroundColor: String?
    public var closeAssistantButtonBorderWidth: Int?
    public var closeAssistantButtonBorderColor: String?
    public var paddingLeft: Int?
    public var paddingRight: Int?
    public var paddingTop: Int?
    public var paddingBottom: Int?
    
    public init(fontSize: Float? = nil, backgroundColor: String? = nil, assistantImage: String? = nil, assistantImageBackgroundColor: String? = nil, assistantName: String? = nil, assistantNameTextColor: String, assistantImageBorderRadius: Float? = nil, assistantImageBorderColor: String? = nil, assistantImageBorderWidth: Int? = nil, closeAssistantButtonImage: String? = nil, closeAssistantButtonBorderRadius: Float? = nil, closeAssistantButtonBackgroundColor: String? = nil, closeAssistantButtonBorderWidth: Int? = nil, closeAssistantButtonBorderColor: String? = nil, paddingLeft: Int? = nil, paddingRight: Int? = nil, paddingTop: Int? = nil, paddingBottom: Int? = nil) {
        self.fontSize = fontSize
        self.backgroundColor = backgroundColor
        self.assistantImage = assistantImage
        self.assistantImageBackgroundColor = assistantImageBackgroundColor
        self.assistantName = assistantName
        self.assistantNameTextColor = assistantNameTextColor
        self.assistantImageBorderRadius = assistantImageBorderRadius
        self.assistantImageBorderColor = assistantImageBorderColor
        self.assistantImageBorderWidth = assistantImageBorderWidth
        self.closeAssistantButtonImage = closeAssistantButtonImage
        self.closeAssistantButtonBorderRadius = closeAssistantButtonBorderRadius
        self.closeAssistantButtonBackgroundColor = closeAssistantButtonBackgroundColor
        self.closeAssistantButtonBorderWidth = closeAssistantButtonBorderWidth
        self.closeAssistantButtonBorderColor = closeAssistantButtonBorderColor
        self.paddingLeft = paddingLeft
        self.paddingRight = paddingRight
        self.paddingTop = paddingTop
        self.paddingBottom = paddingBottom
    }
}
