//
//  CustomAssistantUser.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/25/22.
//

import UIKit

public class CustomAssistantUser : Codable
{
    public var id: String
    public var name: String
    public var accessToken: String
    public var additionalSessionAttributes: Dictionary<String, String>
    public var additionalSessionFlags: Array<String>
    
    public init(id: String, name: String, accessToken: String, additionalSessionAttributes: Dictionary<String, String>, additionalSessionFlags: Array<String>) {
        self.id = id
        self.name = name
        self.accessToken = accessToken
        self.additionalSessionAttributes = additionalSessionAttributes
        self.additionalSessionFlags = additionalSessionFlags
    }
}
