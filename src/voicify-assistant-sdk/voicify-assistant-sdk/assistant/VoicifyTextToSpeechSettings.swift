//
//  VoicifyTextToSpeechSettings.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/26/22.
//

import UIKit

public class VoicifyTextToSpeechSettings
{
    var appId: String
    var appKey: String
    var voice: String
    var serverRootUrl: String
    var provider: String
    
    public init(appId: String, appKey: String, voice: String, serverRootUrl: String, provider: String) {
        self.appId = appId
        self.appKey = appKey
        self.voice = voice
        self.serverRootUrl = serverRootUrl
        self.provider = provider
    }
}
