//
//  VoicifySessionEffect.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/26/22.
//

import UIKit

public class VoicifySessionEffect
{
    public init(effectName: String, requestId: String, data: Any) {
        self.effectName = effectName
        self.requestId = requestId
        self.data = data
    }
    
    var effectName: String
    var requestId: String
    var data: Any    
}
