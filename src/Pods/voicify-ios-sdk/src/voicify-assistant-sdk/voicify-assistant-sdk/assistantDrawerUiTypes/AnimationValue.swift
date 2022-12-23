//
//  AnimationValue.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 12/6/22.
//

import Foundation
import SwiftUI

public class AnimationValue : Identifiable
{
    public var value: CGFloat
    
    public init(value: CGFloat) {
        self.value = value
    }
}
