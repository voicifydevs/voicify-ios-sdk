//
//  ToolBarProps.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 12/6/22.
//

import Foundation
import SwiftUI

public class ToolBarProps {
    public var drawerSpeechHeight: Float? = nil
    public var drawerTextHeight: Float? = nil
    public var backgroundColor: String? = nil
    public var micBorderRadius: Float? = nil
    public var micImagePadding: Float? = nil
    public var micImageBorderWidth: Int? = nil
    public var micImageBorderColor: String? = nil
    public var micImageHeight: Int? = nil
    public var micImageWidth: Int? = nil
    public var sendImageWidth: Int? = nil
    public var sendImageHeight: Int? = nil
    public var micActiveImage: String? = nil
    public var micInactiveImage: String? = nil
    public var micActiveHighlightColor: String? = nil
    public var micInactiveHighlightColor: String? = nil
    public var sendActiveImage: String? = nil
    public var sendInactiveImage: String? = nil
    public var speakFontSize: Float? = nil
    public var speakActiveTitleColor: String? = nil
    public var speakInactiveTitleColor: String? = nil
    public var typeFontSize: Float? = nil
    public var typeActiveTitleColor: String? = nil
    public var typeInactiveTitleColor: String? = nil
    public var textBoxFontSize: Float? = nil
    public var textBoxActiveHighlightColor: String? = nil
    public var textBoxInactiveHighlightColor: String? = nil
    public var partialSpeechResultTextColor: String? = nil
    public var fullSpeechResultTextColor: String? = nil
    public var speechResultBoxBackgroundColor: String? = nil
    public var textInputLineColor: String? = nil
    public var textInputCursorColor: String? = nil
    public var textInputTextColor: String? = nil
    public var paddingLeft: Int? = nil
    public var paddingRight: Int? = nil
    public var paddingTop: Int? = nil
    public var paddingBottom: Int? = nil
    public var placeholder: String? = nil
    public var helpText: String? = nil
    public var helpTextFontSize: Float? = nil
    public var helpTextFontColor: String? = nil
    public var assistantStateTextColor: String? = nil
    public var assistantStateFontSize: Float? = nil
    public var equalizerColor: String? = nil
    public var partialSpeechResultFontFamily: String? = nil
    public var assistantStateFontFamily: String? = nil
    public var helpTextFontFamily: String? = nil
    public var speakFontFamily: String? = nil
    public var typeFontFamily: String? = nil
    public var textboxFontFamily: String? = nil
    public var partialSpeechResultFontSize: Float? = nil;
    public init(drawerSpeechHeight: Float? = nil, drawerTextHeight: Float? = nil, backgroundColor: String? = nil, micBorderRadius: Float? = nil, micImagePadding: Float? = nil, micImageBorderWidth: Int? = nil, micImageBorderColor: String? = nil, micImageHeight: Int? = nil, micImageWidth: Int? = nil, micActiveImage: String? = nil, sendImageWidth: Int? = nil, sendImageHeight: Int? = nil, micInactiveImage: String? = nil, micActiveHighlightColor: String? = nil, micInactiveHighlightColor: String? = nil, sendActiveImage: String? = nil, sendInactiveImage: String? = nil, speakFontSize: Float? = nil, speakActiveTitleColor: String? = nil, speakInactiveTitleColor: String? = nil, typeFontSize: Float? = nil, typeActiveTitleColor: String? = nil, typeInactiveTitleColor: String? = nil, textBoxFontSize: Float? = nil, textBoxActiveHighlightColor: String? = nil, textBoxInactiveHighlightColor: String? = nil, partialSpeechResultTextColor: String? = nil, fullSpeechResultTextColor: String? = nil, speechResultBoxBackgroundColor: String? = nil, textInputLineColor: String? = nil, textInputCursorColor: String? = nil, textInputTextColor: String? = nil, paddingLeft: Int? = nil, paddingRight: Int? = nil, paddingTop: Int? = nil, paddingBottom: Int? = nil, placeholder: String? = nil, helpText: String? = nil, helpTextFontSize: Float? = nil, helpTextFontColor: String? = nil, assistantStateTextColor: String? = nil, assistantStateFontSize: Float? = nil, equalizerColor: String? = nil, partialSpeechResultFontFamily: String? = nil, assistantStateFontFamily: String? = nil, helpTextFontFamily: String? = nil, speakFontFamily: String? = nil, typeFontFamily: String? = nil, textboxFontFamily: String? = nil, partialSpeechResultFonySize: Float? = nil) {
        self.drawerSpeechHeight = drawerSpeechHeight
        self.drawerTextHeight = drawerTextHeight
        self.backgroundColor = backgroundColor
        self.micBorderRadius = micBorderRadius
        self.micImagePadding = micImagePadding
        self.micImageBorderWidth = micImageBorderWidth
        self.micImageBorderColor = micImageBorderColor
        self.micImageHeight = micImageHeight
        self.micImageWidth = micImageWidth
        self.sendImageWidth = sendImageWidth
        self.sendImageHeight = sendImageHeight
        self.micActiveImage = micActiveImage
        self.micInactiveImage = micInactiveImage
        self.micActiveHighlightColor = micActiveHighlightColor
        self.micInactiveHighlightColor = micInactiveHighlightColor
        self.sendActiveImage = sendActiveImage
        self.sendInactiveImage = sendInactiveImage
        self.speakFontSize = speakFontSize
        self.speakActiveTitleColor = speakActiveTitleColor
        self.speakInactiveTitleColor = speakInactiveTitleColor
        self.typeFontSize = typeFontSize
        self.typeActiveTitleColor = typeActiveTitleColor
        self.typeInactiveTitleColor = typeInactiveTitleColor
        self.textBoxFontSize = textBoxFontSize
        self.textBoxActiveHighlightColor = textBoxActiveHighlightColor
        self.textBoxInactiveHighlightColor = textBoxInactiveHighlightColor
        self.partialSpeechResultTextColor = partialSpeechResultTextColor
        self.fullSpeechResultTextColor = fullSpeechResultTextColor
        self.speechResultBoxBackgroundColor = speechResultBoxBackgroundColor
        self.textInputLineColor = textInputLineColor
        self.textInputCursorColor = textInputCursorColor
        self.textInputTextColor = textInputTextColor
        self.paddingLeft = paddingLeft
        self.paddingRight = paddingRight
        self.paddingTop = paddingTop
        self.paddingBottom = paddingBottom
        self.placeholder = placeholder
        self.helpText = helpText
        self.helpTextFontSize = helpTextFontSize
        self.helpTextFontColor = helpTextFontColor
        self.assistantStateTextColor = assistantStateTextColor
        self.assistantStateFontSize = assistantStateFontSize
        self.equalizerColor = equalizerColor
        self.partialSpeechResultFontFamily = partialSpeechResultFontFamily
        self.assistantStateFontFamily = assistantStateFontFamily
        self.helpTextFontFamily = helpTextFontFamily
        self.speakFontFamily = speakFontFamily
        self.typeFontFamily = typeFontFamily
        self.textboxFontFamily = textboxFontFamily
        self.partialSpeechResultFontSize = partialSpeechResultFonySize
    }
}
