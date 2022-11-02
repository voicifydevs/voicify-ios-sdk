//
//  SsmlRequest.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/25/22.
//

import UIKit

public class SsmlRequest : Codable
{
    public var ssml: String
    public var locale: String
    public var voice: String
    
    public init(ssml: String, locale: String, voice: String) {
        self.ssml = ssml
        self.locale = locale
        self.voice = voice
    }
    
}
