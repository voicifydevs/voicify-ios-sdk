//
//  ToolbarProps.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 12/6/22.
//

import Foundation
import SwiftUI

public class ConfigurationToolbarProps: ObservableObject {
    @Published public var drawerSpeechHeight: Float? = nil
    @Published public var drawerTextHeight: Float? = nil
    @Published public var backgroundColor: String? = nil
    @Published public var micBorderRadius: Float? = nil
    @Published public var micImagePadding: Float? = nil
    @Published public var micImageBorderWidth: Int? = nil
    @Published public var micImageBorderColor: String? = nil
    @Published public var micImageHeight: Int? = nil
    @Published public var micImageWidth: Int? = nil
    @Published public var sendImageWidth: Int? = nil
    @Published public var sendImageHeight: Int? = nil
    @Published public var micActiveImage: String? = nil
    @Published public var micInactiveImage: String? = nil
    @Published public var micInactiveColor: String? = nil
    @Published public var micActiveHighlightColor: String? = nil
    @Published public var micInactiveHighlightColor: String? = nil
    @Published public var sendActiveImage: String? = nil
    @Published public var sendInactiveImage: String? = nil
    @Published public var speakFontSize: Float? = nil
    @Published public var speakActiveTitleColor: String? = nil
    @Published public var speakInactiveTitleColor: String? = nil
    @Published public var typeFontSize: Float? = nil
    @Published public var typeActiveTitleColor: String? = nil
    @Published public var typeInactiveTitleColor: String? = nil
    @Published public var textboxFontSize: Float? = nil
    @Published public var textboxInactiveHighlightColor: String? = nil
    @Published public var partialSpeechResultTextColor: String? = nil
    @Published public var fullSpeechResultTextColor: String? = nil
    @Published public var speechResultBoxBackgroundColor: String? = nil
    @Published public var textInputCursorColor: String? = nil
    @Published public var textInputTextColor: String? = nil
    @Published public var paddingLeft: Int? = nil
    @Published public var paddingRight: Int? = nil
    @Published public var paddingTop: Int? = nil
    @Published public var paddingBottom: Int? = nil
    @Published public var placeholder: String? = nil
    @Published public var helpText: String? = nil
    @Published public var helpTextFontSize: Float? = nil
    @Published public var helpTextFontColor: String? = nil
    @Published public var assistantStateFontSize: Float? = nil
    @Published public var partialSpeechResultFontFamily: String? = nil
    @Published public var assistantStateFontFamily: String? = nil
    @Published public var helpTextFontFamily: String? = nil
    @Published public var speakFontFamily: String? = nil
    @Published public var typeFontFamily: String? = nil
    @Published public var textboxFontFamily: String? = nil
    @Published public var partialSpeechResultFontSize: Float? = nil
    @Published public var textInputActiveLineColor: String? = nil
    @Published public var textInputLineColor: String? = nil
    @Published public var textboxActiveHighlightColor: String? = nil
    @Published public var equalizerColor: String? = nil
    @Published public var micActiveColor: String? = nil
    @Published public var sendActiveColor: String? = nil
    @Published public var sendInactiveColor: String? = nil
    @Published public var assistantStateTextColor: String? = nil
    public init(drawerSpeechHeight: Float? = nil, drawerTextHeight: Float? = nil, backgroundColor: String? = nil, micBorderRadius: Float? = nil, micImagePadding: Float? = nil, micImageBorderWidth: Int? = nil, micImageBorderColor: String? = nil, micImageHeight: Int? = nil, micImageWidth: Int? = nil, micActiveImage: String? = nil, sendImageWidth: Int? = nil, sendImageHeight: Int? = nil, micInactiveImage: String? = nil, micInactiveColor: String? = nil, micActiveHighlightColor: String? = nil, micInactiveHighlightColor: String? = nil, sendActiveImage: String? = nil, sendInactiveImage: String? = nil, speakFontSize: Float? = nil, speakActiveTitleColor: String? = nil, speakInactiveTitleColor: String? = nil, typeFontSize: Float? = nil, typeActiveTitleColor: String? = nil, typeInactiveTitleColor: String? = nil, textboxFontSize: Float? = nil, textboxInactiveHighlightColor: String? = nil, partialSpeechResultTextColor: String? = nil, fullSpeechResultTextColor: String? = nil, speechResultBoxBackgroundColor: String? = nil, textInputCursorColor: String? = nil, textInputTextColor: String? = nil, paddingLeft: Int? = nil, paddingRight: Int? = nil, paddingTop: Int? = nil, paddingBottom: Int? = nil, placeholder: String? = nil, helpText: String? = nil, helpTextFontSize: Float? = nil, helpTextFontColor: String? = nil, assistantStateFontSize: Float? = nil, partialSpeechResultFontFamily: String? = nil, assistantStateFontFamily: String? = nil, helpTextFontFamily: String? = nil, speakFontFamily: String? = nil, typeFontFamily: String? = nil, textboxFontFamily: String? = nil, partialSpeechResultFonySize: Float? = nil, textInputActiveLineColor: String? = nil, textInputLineColor: String? = nil, textboxActiveHighlightColor: String? = nil, equalizerColor: String? = nil, micActiveColor: String? = nil, sendActiveColor: String? = nil, sendInactiveColor: String? = nil, assistantStateTextColor: String? = nil) {
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
        self.micInactiveColor = micInactiveColor
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
        self.textboxFontSize = textboxFontSize
        self.textboxInactiveHighlightColor = textboxInactiveHighlightColor
        self.partialSpeechResultTextColor = partialSpeechResultTextColor
        self.fullSpeechResultTextColor = fullSpeechResultTextColor
        self.speechResultBoxBackgroundColor = speechResultBoxBackgroundColor
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
        self.assistantStateFontSize = assistantStateFontSize
        self.partialSpeechResultFontFamily = partialSpeechResultFontFamily
        self.assistantStateFontFamily = assistantStateFontFamily
        self.helpTextFontFamily = helpTextFontFamily
        self.speakFontFamily = speakFontFamily
        self.typeFontFamily = typeFontFamily
        self.textboxFontFamily = textboxFontFamily
        self.partialSpeechResultFontSize = partialSpeechResultFonySize
        self.textInputActiveLineColor = textInputActiveLineColor
        self.textInputLineColor = textInputLineColor
        self.textboxActiveHighlightColor = textboxActiveHighlightColor
        self.equalizerColor = equalizerColor
        self.micActiveColor = micActiveColor
        self.sendActiveColor = sendActiveColor
        self.sendInactiveColor = sendInactiveColor
        self.assistantStateTextColor = assistantStateTextColor
    }
}
