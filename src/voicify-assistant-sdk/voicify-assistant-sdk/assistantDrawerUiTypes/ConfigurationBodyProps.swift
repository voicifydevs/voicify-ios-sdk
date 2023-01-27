//
//  BodyProps.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 12/6/22.
//

import Foundation

public class ConfigurationBodyProps: ObservableObject {
    @Published public var backgroundColor: String? = nil
    @Published public var assistantImageBorderColor: String? = nil
    @Published public var assistantImageBorderWidth: Int? = nil
    @Published public var assistantImageBorderRadius: Float? = nil
    @Published public var assistantImage: String? = nil
    @Published public var assistantImageColor: String? = nil
    @Published public var assistantImageHeight: Int? = nil
    @Published public var assistantImageWidth: Int? = nil
    @Published public var assistantImageBackgroundColor: String? = nil
    @Published public var messageSentTextColor: String? = nil
    @Published public var messageSentBackgroundColor: String? = nil
    @Published public var messageReceivedFontSize: Float? = nil
    @Published public var messageReceivedTextColor: String? = nil
    @Published public var messageReceivedBackgroundColor: String? = nil
    @Published public var messageSentFontSize: Float? = nil
    @Published public var messageSentBorderWidth: Int? = nil
    @Published public var messageSentBorderColor: String? = nil
    @Published public var messageSentFontFamily: String? = nil
    @Published public var messageReceivedBorderWidth: Int? = nil
    @Published public var messageReceivedBorderColor: String? = nil
    @Published public var messageSentBorderTopLeftRadius: Float? = nil
    @Published public var messageSentBorderTopRightRadius: Float? = nil
    @Published public var messageSentBorderBottomLeftRadius: Float? = nil
    @Published public var messageSentBorderBottomRightRadius: Float? = nil
    @Published public var messageReceivedBorderTopLeftRadius: Float? = nil
    @Published public var messageReceivedBorderTopRightRadius: Float? = nil
    @Published public var messageReceivedBorderBottomLeftRadius: Float? = nil
    @Published public var messageReceivedBorderBottomRightRadius: Float? = nil
    @Published public var messageReceivedFontFamily: String? = nil
    @Published public var paddingLeft: Int? = nil
    @Published public var paddingRight: Int? = nil
    @Published public var paddingTop: Int? = nil
    @Published public var paddingBottom: Int? = nil
    @Published public var borderTopColor: String? = nil
    @Published public var borderBottomColor: String? = nil
    @Published public var borderTopWidth: Float? = nil
    @Published public var borderBottomWidth: Float? = nil
    @Published public var hintsTextColor: String? = nil
    @Published public var hintsFontSize: Float? = nil
    @Published public var hintsPaddingTop: Int? = nil
    @Published public var hintsPaddingBottom: Int? = nil
    @Published public var hintsPaddingRight: Int? = nil
    @Published public var hintsPaddingLeft: Int? = nil
    @Published public var hintsBackgroundColor: String? = nil
    @Published public var hintsBorderWidth: Float? = nil
    @Published public var hintsBorderColor: String? = nil
    @Published public var hintsBorderRadius: Float? = nil
    @Published public var hintsFontFamily: String? = nil
    
    public init(backgroundColor: String? = nil, assistantImageBorderColor: String? = nil, assistantImageBorderWidth: Int? = nil, assistantImageBorderRadius: Float? = nil, assistantImage: String? = nil, assistantImageColor: String? = nil, assistantImageHeight: Int? = nil, assistantImageWidth: Int? = nil, assistantImageBackgroundColor: String? = nil, messageSentTextColor: String? = nil, messageSentBackgroundColor: String? = nil, messageReceivedFontSize: Float? = nil, messageReceivedTextColor: String? = nil, messageReceivedBackgroundColor: String? = nil, messageSentFontSize: Float? = nil, messageSentBorderWidth: Int? = nil, messageSentBorderColor: String? = nil, messageSentFontFamily: String? = nil, messageReceivedBorderWidth: Int? = nil, messageReceivedBorderColor: String? = nil, messageSentBorderTopLeftRadius: Float? = nil, messageSentBorderTopRightRadius: Float? = nil, messageSentBorderBottomLeftRadius: Float? = nil, messageSentBorderBottomRightRadius: Float? = nil, messageReceivedBorderTopLeftRadius: Float? = nil, messageReceivedBorderTopRightRadius: Float? = nil, messageReceivedBorderBottomLeftRadius: Float? = nil, messageReceivedBorderBottomRightRadius: Float? = nil, messageReceivedFontFamily: String? = nil, paddingLeft: Int? = nil, paddingRight: Int? = nil, paddingTop: Int? = nil, paddingBottom: Int? = nil, borderTopColor: String? = nil, borderBottomColor: String? = nil, borderTopWidth: Float? = nil, borderBottomWidth: Float? = nil, hintsTextColor: String? = nil, hintsFontSize: Float? = nil, hintsPaddingTop: Int? = nil, hintsPaddingBottom: Int? = nil, hintsPaddingRight: Int? = nil, hintsPaddingLeft: Int? = nil, hintsBackgroundColor: String? = nil, hintsBorderWidth: Float? = nil, hintsBorderColor: String? = nil, hintsBorderRadius: Float? = nil, hintsFontFamily: String? = nil) {
        self.backgroundColor = backgroundColor
        self.assistantImageBorderColor = assistantImageBorderColor
        self.assistantImageBorderWidth = assistantImageBorderWidth
        self.assistantImageBorderRadius = assistantImageBorderRadius
        self.assistantImage = assistantImage
        self.assistantImageColor = assistantImageColor
        self.assistantImageHeight = assistantImageHeight
        self.assistantImageWidth = assistantImageWidth
        self.assistantImageBackgroundColor = assistantImageBackgroundColor
        self.messageSentTextColor = messageSentTextColor
        self.messageSentBackgroundColor = messageSentBackgroundColor
        self.messageReceivedFontSize = messageReceivedFontSize
        self.messageReceivedTextColor = messageReceivedTextColor
        self.messageReceivedBackgroundColor = messageReceivedBackgroundColor
        self.messageSentFontSize = messageSentFontSize
        self.messageSentBorderWidth = messageSentBorderWidth
        self.messageSentBorderColor = messageSentBorderColor
        self.messageSentFontFamily = messageSentFontFamily
        self.messageReceivedBorderWidth = messageReceivedBorderWidth
        self.messageReceivedBorderColor = messageReceivedBorderColor
        self.messageSentBorderTopLeftRadius = messageSentBorderTopLeftRadius
        self.messageSentBorderTopRightRadius = messageSentBorderTopRightRadius
        self.messageSentBorderBottomLeftRadius = messageSentBorderBottomLeftRadius
        self.messageSentBorderBottomRightRadius = messageSentBorderBottomRightRadius
        self.messageReceivedBorderTopLeftRadius = messageReceivedBorderTopLeftRadius
        self.messageReceivedBorderTopRightRadius = messageReceivedBorderTopRightRadius
        self.messageReceivedBorderBottomLeftRadius = messageReceivedBorderBottomLeftRadius
        self.messageReceivedBorderBottomRightRadius = messageReceivedBorderBottomRightRadius
        self.messageReceivedFontFamily = messageReceivedFontFamily
        self.paddingLeft = paddingLeft
        self.paddingRight = paddingRight
        self.paddingTop = paddingTop
        self.paddingBottom = paddingBottom
        self.borderTopColor = borderTopColor
        self.borderBottomColor = borderBottomColor
        self.borderTopWidth = borderTopWidth
        self.borderBottomWidth = borderBottomWidth
        self.hintsTextColor = hintsTextColor
        self.hintsFontSize = hintsFontSize
        self.hintsPaddingTop = hintsPaddingTop
        self.hintsPaddingBottom = hintsPaddingBottom
        self.hintsPaddingRight = hintsPaddingRight
        self.hintsPaddingLeft = hintsPaddingLeft
        self.hintsBackgroundColor = hintsBackgroundColor
        self.hintsBorderWidth = hintsBorderWidth
        self.hintsBorderColor = hintsBorderColor
        self.hintsBorderRadius = hintsBorderRadius
        self.hintsFontFamily = hintsFontFamily
    }
}
