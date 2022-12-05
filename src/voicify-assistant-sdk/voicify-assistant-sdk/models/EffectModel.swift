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
    public var callback: (Dictionary<String, Any>) -> Void
    
    public init(effect: String, callback: @escaping (Dictionary<String, Any>) -> Void) {
        self.effect = effect
        self.callback = callback
    }
}
