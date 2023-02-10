//
//  HintsViewParameters.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 1/27/23.
//

import UIKit

public class HintsViewParameters
{
    public var font: String
    public var fontSize: Float
    public var foregroundColor: String
    public var paddingTop: Int
    public var paddingRight: Int
    public var paddingBottom: Int
    public var paddingLeft: Int
    
    public init (font: String = "", fontSize: Float = 0, foregroundColor: String = "", paddingTop: Int = 0, paddingRight: Int = 0, paddingBottom: Int = 0, paddingLeft: Int = 0) {
        self.font = font
        self.fontSize = fontSize
        self.foregroundColor = foregroundColor
        self.paddingTop = paddingTop
        self.paddingRight = paddingRight
        self.paddingBottom = paddingBottom
        self.paddingLeft = paddingLeft
    }
}
