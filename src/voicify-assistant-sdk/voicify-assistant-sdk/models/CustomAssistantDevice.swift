//
//  CustomAssistantDevice.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/24/22.
//

import UIKit

public class CustomAssistantDevice
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
    
    public init(id: String, name: String, supportsVideo: Bool, supportsForegroundImage: Bool, supportsBackgroundImage: Bool, supportsAudio: Bool, supportsSsml: Bool, supportsDisplayText: Bool, supportsVoiceInput: Bool, supportsTextInput: Bool) {
        self.id = id
        self.name = name
        self.supportsVideo = supportsVideo
        self.supportsForegroundImage = supportsForegroundImage
        self.supportsBackgroundImage = supportsBackgroundImage
        self.supportsAudio = supportsAudio
        self.supportsSsml = supportsSsml
        self.supportsDisplayText = supportsDisplayText
        self.supportsVoiceInput = supportsVoiceInput
        self.supportsTextInput = supportsTextInput
    }
}
