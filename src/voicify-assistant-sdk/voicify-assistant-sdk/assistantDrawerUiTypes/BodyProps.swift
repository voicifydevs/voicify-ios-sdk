//
//  BodyProps.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 12/6/22.
//

import Foundation

public class BodyProps {
    public var backgroundColor: String? = nil
    public var assistantImageBorderColor: String? = nil
    public var assistantImageBorderWidth: Int? = nil
    public var assistantImageBorderRadius: Float? = nil
    public var assistantImage: String? = nil
    public var assistantImageHeight: Int? = nil
    public var assistantImageWidth: Int? = nil
    public var assistantImageBackgroundColor: String? = nil
    public var messageSentTextColor: String? = nil
    public var messageSentBackgroundColor: String? = nil
    public var messageReceivedFontSize: Float? = nil
    public var messageReceivedTextColor: String? = nil
    public var messageReceivedBackgroundColor: String? = nil
    public var messageSentFontSize: Float? = nil
    public var messageSentBorderWidth: Int? = nil
    public var messageSentBorderColor: String? = nil
    public var messageSentFontFamily: String? = nil
    public var messageReceivedBorderWidth: Int? = nil
    public var messageReceivedBorderColor: String? = nil
    public var messageSentBorderTopLeftRadius: Float? = nil
    public var messageSentBorderTopRightRadius: Float? = nil
    public var messageSentBorderBottomLeftRadius: Float? = nil
    public var messageSentBorderBottomRightRadius: Float? = nil
    public var messageReceivedBorderTopLeftRadius: Float? = nil
    public var messageReceivedBorderTopRightRadius: Float? = nil
    public var messageReceivedBorderBottomLeftRadius: Float? = nil
    public var messageReceivedBorderBottomRightRadius: Float? = nil
    public var messageReceivedFontFamily: String? = nil
    public var paddingLeft: Int? = nil
    public var paddingRight: Int? = nil
    public var paddingTop: Int? = nil
    public var paddingBottom: Int? = nil
    public var borderTopColor: String? = nil
    public var borderBottomColor: String? = nil
    public var borderTopWidth: Float? = nil
    public var borderBottomWidth: Float? = nil
    public var hintsTextColor: String? = nil
    public var hintsFontSize: Float? = nil
    public var hintsPaddingTop: Int? = nil
    public var hintsPaddingBottom: Int? = nil
    public var hintsPaddingRight: Int? = nil
    public var hintsPaddingLeft: Int? = nil
    public var hintsBackgroundColor: String? = nil
    public var hintsBorderWidth: Float? = nil
    public var hintsBorderColor: String? = nil
    public var hintsBorderRadius: Float? = nil
    public var hintsFontFamily: String? = nil
    
    public init(backgroundColor: String? = nil, assistantImageBorderColor: String? = nil, assistantImageBorderWidth: Int? = nil, assistantImageBorderRadius: Float? = nil, assistantImage: String? = nil, assistantImageHeight: Int? = nil, assistantImageWidth: Int? = nil, assistantImageBackgroundColor: String? = nil, messageSentTextColor: String? = nil, messageSentBackgroundColor: String? = nil, messageReceivedFontSize: Float? = nil, messageReceivedTextColor: String? = nil, messageReceivedBackgroundColor: String? = nil, messageSentFontSize: Float? = nil, messageSentBorderWidth: Int? = nil, messageSentBorderColor: String? = nil, messageSentFontFamily: String? = nil, messageReceivedBorderWidth: Int? = nil, messageReceivedBorderColor: String? = nil, messageSentBorderTopLeftRadius: Float? = nil, messageSentBorderTopRightRadius: Float? = nil, messageSentBorderBottomLeftRadius: Float? = nil, messageSentBorderBottomRightRadius: Float? = nil, messageReceivedBorderTopLeftRadius: Float? = nil, messageReceivedBorderTopRightRadius: Float? = nil, messageReceivedBorderBottomLeftRadius: Float? = nil, messageReceivedBorderBottomRightRadius: Float? = nil, messageReceivedFontFamily: String? = nil, paddingLeft: Int? = nil, paddingRight: Int? = nil, paddingTop: Int? = nil, paddingBottom: Int? = nil, borderTopColor: String? = nil, borderBottomColor: String? = nil, borderTopWidth: Float? = nil, borderBottomWidth: Float? = nil, hintsTextColor: String? = nil, hintsFontSize: Float? = nil, hintsPaddingTop: Int? = nil, hintsPaddingBottom: Int? = nil, hintsPaddingRight: Int? = nil, hintsPaddingLeft: Int? = nil, hintsBackgroundColor: String? = nil, hintsBorderWidth: Float? = nil, hintsBorderColor: String? = nil, hintsBorderRadius: Float? = nil, hintsFontFamily: String? = nil) {
        self.backgroundColor = backgroundColor
        self.assistantImageBorderColor = assistantImageBorderColor
        self.assistantImageBorderWidth = assistantImageBorderWidth
        self.assistantImageBorderRadius = assistantImageBorderRadius
        self.assistantImage = assistantImage
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
