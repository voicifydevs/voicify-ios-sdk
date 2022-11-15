//
//  CustomAssistantListItem.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/25/22.
//

import UIKit

public class Message : Identifiable
{
    public var text: String
    public var origin: String
    
    public init(text: String, origin: String) {
        self.text = text
        self.origin = origin
    }
}
