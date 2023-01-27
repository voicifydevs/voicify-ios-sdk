//
//  ToolbarParameters.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 1/27/23.
//

import UIKit

public class ToolbarParameters
{
    public var assistantStatefont: String
    public var assistantStateFontSize: Float
    public var assistantStateForegroundColor: String
    public var inputSpeechStatefont: String
    public var inputSpeechFontSize: Float
    public var inputSpeechPartialForegroundColor: String
    public var inputSpeechFinalForegroundColor: String
    public var helpFont: String
    public var helpFontSize: Float
    public var helpForegroundColor: String
    public var speakFont: String
    public var speakFontSize: Float
    public var speakActiveForegroundColor: String
    public var speakInactiveForegroundColor: String
    public var typeFont: String
    public var typeFontSize: Float
    public var typeActiveForegroundColor: String
    public var typeInactiveForegroundColor: String
    public var paddingTop: Int
    public var paddingRight: Int
    public var paddingBottom: Int
    public var paddingLeft: Int
    public init (assistantStatefont: String = "", assistantStateFontSize: Float = 0, assistantStateForegroundColor: String = "", inputSpeechStatefont: String = "",  inputSpeechFontSize: Float = 0, inputSpeechPartialForegroundColor: String = "", inputSpeechFinalForegroundColor: String = "", helpFont: String = "", helpFontSize: Float = 0, helpForegroundColor: String = "", speakFont: String = "", speakFontSize: Float = 0, speakActiveForegroundColor: String = "", speakInactiveForegroundColor: String = "", typeFont: String = "", typeFontSize: Float = 0, typeActiveForegroundColor: String = "",typeInactiveForegroundColor: String = "", paddingTop: Int = 0, paddingRight: Int = 0, paddingBottom: Int = 0, paddingLeft: Int = 0) {
        self.assistantStatefont = assistantStatefont
        self.assistantStateFontSize = assistantStateFontSize
        self.assistantStateForegroundColor = assistantStateForegroundColor
        self.inputSpeechStatefont = inputSpeechStatefont
        self.inputSpeechFontSize = inputSpeechFontSize
        self.inputSpeechPartialForegroundColor = inputSpeechPartialForegroundColor
        self.inputSpeechFinalForegroundColor = inputSpeechFinalForegroundColor
        self.helpFont = helpFont
        self.helpFontSize = helpFontSize
        self.helpForegroundColor = helpForegroundColor
        self.speakFont = speakFont
        self.speakFontSize = speakFontSize
        self.speakActiveForegroundColor = speakActiveForegroundColor
        self.speakInactiveForegroundColor = speakInactiveForegroundColor
        self.typeFont = typeFont
        self.typeFontSize = typeFontSize
        self.typeActiveForegroundColor = typeActiveForegroundColor
        self.typeInactiveForegroundColor = typeInactiveForegroundColor
        self.paddingTop = paddingTop
        self.paddingRight = paddingRight
        self.paddingBottom = paddingBottom
        self.paddingLeft = paddingLeft
    }
}
