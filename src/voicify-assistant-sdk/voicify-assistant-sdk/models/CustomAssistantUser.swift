//
//  CustomAssistantUser.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/25/22.
//

import UIKit

public class CustomAssistantUser
{
    var id: String
    var name: String
    var accessToken: String
    var additionalSessionAttributes: Dictionary<String, Any>
    var additionalSessionFlags: Array<String>
    
    public init(id: String, name: String? = nil, accessToken: String? = nil, additionalSessionAttributes: Dictionary<String, Any>? = nil, additionalSessionFlags: Array<String>? = nil) {
        self.id = id
        self.name = name ?? ""
        self.accessToken = accessToken ?? ""
        self.additionalSessionAttributes = additionalSessionAttributes ?? [:]
        self.additionalSessionFlags = additionalSessionFlags ?? []
    }
}
