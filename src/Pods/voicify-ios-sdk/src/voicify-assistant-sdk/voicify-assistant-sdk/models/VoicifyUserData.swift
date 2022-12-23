//
//  VoicifyUserData.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/26/22.
//

import UIKit

public class VoicifyUserData
{
    public var id: String
    public var userFlags: Array<String>
    public  var userAttributes: Dictionary<String, Any>
    
    public init(id: String, userFlags: Array<String>, userAttributes: Dictionary<String, Any>) {
        self.id = id
        self.userFlags = userFlags
        self.userAttributes = userAttributes
    }
}
