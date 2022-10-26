//
//  VoicifyUserData.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/26/22.
//

import UIKit

public class VoicifyUserData
{
    var id: String
    var userFlags: Array<String>
    var sessionAttributes: Dictionary<String, Any>
    
    public init(id: String, userFlags: Array<String>, sessionAttributes: Dictionary<String, Any>) {
        self.id = id
        self.userFlags = userFlags
        self.sessionAttributes = sessionAttributes
    }
}
