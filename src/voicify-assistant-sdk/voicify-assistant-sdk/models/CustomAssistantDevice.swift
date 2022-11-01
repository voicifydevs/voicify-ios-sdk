//
//  CustomAssistantDevice.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/24/22.
//

import UIKit

public class CustomAssistantDevice : Encodable
{
    var id: String
    var name: String
    var supportsVideo: Bool
    var supportsForegroundImage: Bool
    var supportsBackgroundImage: Bool
    var supportsAudio: Bool
    var supportsSsml: Bool
    var supportsDisplayText: Bool
    var supportsVoiceInput: Bool
    var supportsTextInput: Bool
    
    public init(id: String, name: String, supportsVideo: Bool? = false, supportsForegroundImage: Bool? = false, supportsBackgroundImage: Bool? = false, supportsAudio: Bool? = false, supportsSsml: Bool? = false, supportsDisplayText: Bool? = false, supportsVoiceInput: Bool? = false, supportsTextInput: Bool? = false) {
        self.id = id
        self.name = name
        self.supportsVideo = supportsVideo ?? false
        self.supportsForegroundImage = supportsForegroundImage ?? false
        self.supportsBackgroundImage = supportsBackgroundImage ?? false
        self.supportsAudio = supportsAudio ?? false
        self.supportsSsml = supportsSsml ?? false
        self.supportsDisplayText = supportsDisplayText ?? false
        self.supportsVoiceInput = supportsVoiceInput ?? false
        self.supportsTextInput = supportsTextInput ?? false
    }
}
