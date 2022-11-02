//
//  VoicifySessionData.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/26/22.
//

import UIKit

public class VoicifySessionData
{
    public var id: String
    public var sessionFlags: Array<String>
    public var sessionAttributes: Dictionary<String, Any>
    
    public init(id: String, sessionFlags: Array<String>, sessionAttributes: Dictionary<String, Any>) {
        self.id = id
        self.sessionFlags = sessionFlags
        self.sessionAttributes = sessionAttributes
    }
}
