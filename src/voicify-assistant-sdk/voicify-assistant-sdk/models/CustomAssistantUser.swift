//
//  CustomAssistantUser.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/25/22.
//

import UIKit

public class CustomAssistantUser
{
    public var id: String
    public var name: String
    public var accessToken: String
    public var additionalSessionAttributes: Dictionary<String, Any>
    public var additionalSessionFlags: Array<String>
    
    public init(id: String, name: String, accessToken: String, additionalSessionAttributes: Dictionary<String, Any>, additionalSessionFlags: Array<String>) {
        self.id = id
        self.name = name
        self.accessToken = accessToken
        self.additionalSessionAttributes = additionalSessionAttributes
        self.additionalSessionFlags = additionalSessionFlags
    }
}
