//
//  SsmlRequest.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/25/22.
//

import UIKit

public class SsmlRequest
{
    var ssml: String
    var locale: String
    var voice: String
    
    internal init(ssml: String, locale: String, voice: String) {
        self.ssml = ssml
        self.locale = locale
        self.voice = voice
    }
    
}
