//
//  CustomAssistantResponse.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/25/22.
//

import UIKit

public class CustomAssistantResponse
{
    var responseid: String
    var ssml: String
    var outputSpeech: String
    var displayText: String
    var responseTemplate: String
    var foregroundImage: String
    var backgroundImage: String
    var audioFile: MediaItemModel
    var videoFile: MediaItemModel
    var sessionAttributes: Dictionary<String, Any>
    var hints: Array<String>
    var listItems: Array<CustomAssistantListItem>
    var endSession: Bool
    
    public init(responseid: String, ssml: String, outputSpeech: String, displayText: String, responseTemplate: String, foregroundImage: String, backgroundImage: String, audioFile: MediaItemModel, videoFile: MediaItemModel, sessionAttributes: Dictionary<String, Any>, hints: Array<String>, listItems: Array<CustomAssistantListItem>, endSession: Bool) {
        self.responseid = responseid
        self.ssml = ssml
        self.outputSpeech = outputSpeech
        self.displayText = displayText
        self.responseTemplate = responseTemplate
        self.foregroundImage = foregroundImage
        self.backgroundImage = backgroundImage
        self.audioFile = audioFile
        self.videoFile = videoFile
        self.sessionAttributes = sessionAttributes
        self.hints = hints
        self.listItems = listItems
        self.endSession = endSession
    }
}
