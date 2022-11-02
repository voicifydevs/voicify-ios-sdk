//
//  EffectModel.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/25/22.
//

import UIKit

public class EffectModel
{
    public var effect: String
    public var callback: (Any) -> Void
    
    public init(effect: String, callback: @escaping (Any) -> Void) {
        self.effect = effect
        self.callback = callback
    }
}
