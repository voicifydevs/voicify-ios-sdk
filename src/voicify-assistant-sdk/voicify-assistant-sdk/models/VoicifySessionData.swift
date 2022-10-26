//
//  VoicifySessionData.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/26/22.
//

import UIKit

public class VoicifySessionData
{
    public init(id: String, sessionFlags: Array<String>, sessionAttributes: Dictionary<String, Any>) {
        self.id = id
        self.sessionFlags = sessionFlags
        self.sessionAttributes = sessionAttributes
    }
    
    var id: String
    var sessionFlags: Array<String>
    var sessionAttributes: Dictionary<String, Any>
}
