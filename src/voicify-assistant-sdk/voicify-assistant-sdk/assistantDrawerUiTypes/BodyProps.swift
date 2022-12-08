//
//  BodyProps.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 12/6/22.
//

import Foundation

public class BodyProps {
    //val height: String? = null,
    public var backgroundColor: String? = nil
    public var assistantImageBorderColor: String? = nil
    public var assistantImageBorderWidth: Int? = nil
    //val assistantImageBorderStyle: String? = null,
    public var assistantImageBorderRadius: Float? = nil
    public var assistantImage: String? = nil
    public var messageSentTextColor: String? = nil
    public var messageSentBackgroundColor: String? = nil
    public var messageReceivedFontSize: Float? = nil
    public var messageReceivedTextColor: String? = nil
    public var messageReceivedBackgroundColor: String? = nil
    public var messageSentFontSize: Float? = nil
    public var messageSentBorderWidth: Int? = nil
    //val messageSentBorderStyle: String? = null,
    public var messageSentBorderColor: String? = nil
    public var messageReceivedBorderWidth: Int? = nil
    //val messageReceivedBorderStyle: String? = null,
    public var messageReceivedBorderColor: String? = nil
    public var messageSentBorderTopLeftRadius: Float? = nil
    public var messageSentBorderTopRightRadius: Float? = nil
    public var messageSentBorderBottomLeftRadius: Float? = nil
    public var messageSentBorderBottomRightRadius: Float? = nil
    public var messageReceivedBorderTopLeftRadius: Float? = nil
    public var messageReceivedBorderTopRightRadius: Float? = nil
    public var messageReceivedBorderBottomLeftRadius: Float? = nil
    public var messageReceivedBorderBottomRightRadius: Float? = nil
    public var paddingLeft: Int? = nil
    public var paddingRight: Int? = nil
    public var paddingTop: Int? = nil
    public var paddingBottom: Int? = nil
//    val borderTopColor: String? = null,
//    val borderBottomColor: String? = null,
    public var borderColor: String? = nil
    public var hintsTextColor: String? = nil
    public var hintsFontSize: Float? = nil
    public var hintsPaddingTop: Int? = nil
    public var hintsPaddingBottom: Int? = nil
    public var hintsPaddingRight: Int? = nil
    public var hintsPaddingLeft: Int? = nil
    public var hintsBackgroundColor: String? = nil
    public var hintsBorderWidth: Int? = nil
    public var hintsBorderColor: String? = nil
    //val hintsBorderStyle: String? = null,
    public var hintsBorderRadius: Float? = nil
    
    public init(backgroundColor: String? = nil, assistantImageBorderColor: String? = nil, assistantImageBorderWidth: Int? = nil, assistantImageBorderRadius: Float? = nil, assistantImage: String? = nil, messageSentTextColor: String? = nil, messageSentBackgroundColor: String? = nil, messageReceivedFontSize: Float? = nil, messageReceivedTextColor: String? = nil, messageReceivedBackgroundColor: String? = nil, messageSentFontSize: Float? = nil, messageSentBorderWidth: Int? = nil, messageSentBorderColor: String? = nil, messageReceivedBorderWidth: Int? = nil, messageReceivedBorderColor: String? = nil, messageSentBorderTopLeftRadius: Float? = nil, messageSentBorderTopRightRadius: Float? = nil, messageSentBorderBottomLeftRadius: Float? = nil, messageSentBorderBottomRightRadius: Float? = nil, messageReceivedBorderTopLeftRadius: Float? = nil, messageReceivedBorderTopRightRadius: Float? = nil, messageReceivedBorderBottomLeftRadius: Float? = nil, messageReceivedBorderBottomRightRadius: Float? = nil, paddingLeft: Int? = nil, paddingRight: Int? = nil, paddingTop: Int? = nil, paddingBottom: Int? = nil, borderColor: String? = nil, hintsTextColor: String? = nil, hintsFontSize: Float? = nil, hintsPaddingTop: Int? = nil, hintsPaddingBottom: Int? = nil, hintsPaddingRight: Int? = nil, hintsPaddingLeft: Int? = nil, hintsBackgroundColor: String? = nil, hintsBorderWidth: Int? = nil, hintsBorderColor: String? = nil, hintsBorderRadius: Float? = nil) {
        self.backgroundColor = backgroundColor
        self.assistantImageBorderColor = assistantImageBorderColor
        self.assistantImageBorderWidth = assistantImageBorderWidth
        self.assistantImageBorderRadius = assistantImageBorderRadius
        self.assistantImage = assistantImage
        self.messageSentTextColor = messageSentTextColor
        self.messageSentBackgroundColor = messageSentBackgroundColor
        self.messageReceivedFontSize = messageReceivedFontSize
        self.messageReceivedTextColor = messageReceivedTextColor
        self.messageReceivedBackgroundColor = messageReceivedBackgroundColor
        self.messageSentFontSize = messageSentFontSize
        self.messageSentBorderWidth = messageSentBorderWidth
        self.messageSentBorderColor = messageSentBorderColor
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
        self.paddingLeft = paddingLeft
        self.paddingRight = paddingRight
        self.paddingTop = paddingTop
        self.paddingBottom = paddingBottom
        self.borderColor = borderColor
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
    }
}