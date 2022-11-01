//
//  VoicifySessionData.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/26/22.
//

import UIKit

public class VoicifySessionData
{
    var id: String?
    var sessionFlags: Array<String>?
    var sessionAttributes: Dictionary<String, Any>?
    
    public init(id: String? = nil, sessionFlags: Array<String>? = nil, sessionAttributes: Dictionary<String, Any>? = nil) {
        self.id = id
        self.sessionFlags = sessionFlags
        self.sessionAttributes = sessionAttributes
    }
}
