//
//  VoicifySessionEffect.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/26/22.
//

import UIKit

public class VoicifySessionEffect
{
    public var id: String
    public var effectName: String
    public var requestId: String
    public var name: String
    public var data: Dictionary<String,Any>
    
    public init(id: String, effectName: String, requestId: String, name: String, data: Dictionary<String,Any>) {
        self.id = id
        self.effectName = effectName
        self.requestId = requestId
        self.name = name
        self.data = data
    }
}
