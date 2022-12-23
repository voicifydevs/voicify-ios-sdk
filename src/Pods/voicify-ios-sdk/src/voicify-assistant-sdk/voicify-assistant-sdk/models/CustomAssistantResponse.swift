//
//  CustomAssistantResponse.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/25/22.
//

import UIKit

public class CustomAssistantResponse
{
    public var responseId: String
    public var ssml: String
    public var outputSpeech: String
    public var displayText: String
    public var responseTemplate: String
    public var foregroundImage: String
    public var backgroundImage: String
    public var audioFile: MediaItemModel
    public var videoFile: MediaItemModel
    public var sessionAttributes: Dictionary<String, Any>
    public var sessionFlags: Array<String>
    public var effects: Array<VoicifySessionEffect>
    public var hints: Array<String>
    public var listItems: Array<CustomAssistantListItem>
    public var endSession: Bool
    
    public init(responseId: String, ssml: String, outputSpeech: String, displayText: String, responseTemplate: String, foregroundImage: String, backgroundImage: String, audioFile: MediaItemModel, videoFile: MediaItemModel, sessionAttributes: Dictionary<String, Any>,
                sessionFlags: Array<String>, effects: Array<VoicifySessionEffect>, hints: Array<String>, listItems: Array<CustomAssistantListItem>, endSession: Bool) {
        self.responseId = responseId
        self.ssml = ssml
        self.outputSpeech = outputSpeech
        self.displayText = displayText
        self.responseTemplate = responseTemplate
        self.foregroundImage = foregroundImage
        self.backgroundImage = backgroundImage
        self.audioFile = audioFile
        self.videoFile = videoFile
        self.sessionAttributes = sessionAttributes
        self.sessionFlags = sessionFlags
        self.effects = effects
        self.hints = hints
        self.listItems = listItems
        self.endSession = endSession
        
        
    }
}
