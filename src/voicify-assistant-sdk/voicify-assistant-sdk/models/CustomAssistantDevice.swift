//
//  CustomAssistantDevice.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/24/22.
//

import UIKit

public class CustomAssistantDevice : Codable
{
    public var id: String
    public var name: String
    public var supportsVideo: Bool
    public var supportsForegroundImage: Bool
    public var supportsBackgroundImage: Bool
    public var supportsAudio: Bool
    public var supportsSsml: Bool
    public var supportsDisplayText: Bool
    public var supportsVoiceInput: Bool
    public var supportsTextInput: Bool
    
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
