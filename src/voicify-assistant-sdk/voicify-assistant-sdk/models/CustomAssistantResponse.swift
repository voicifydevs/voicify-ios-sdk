//
//  CustomAssistantResponse.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/25/22.
//

import UIKit

public class CustomAssistantResponse
{
    var responseId: String
    var ssml: String?
    var outputSpeech: String?
    var displayText: String
    var responseTemplate: String
    var foregroundImage: String
    var backgroundImage: String
    var audioFile: MediaItemModel?
    var videoFile: MediaItemModel?
    var sessionAttributes: Dictionary<String, Any>?
    var hints: Array<String>?
    var listItems: Array<CustomAssistantListItem>?
    var endSession: Bool?
    
    public init(responseId: String, ssml: String? = nil, outputSpeech: String? = nil, displayText: String, responseTemplate: String, foregroundImage: String, backgroundImage: String, audioFile: MediaItemModel? = nil, videoFile: MediaItemModel? = nil, sessionAttributes: Dictionary<String, Any>? = nil, hints: Array<String>? = nil, listItems: Array<CustomAssistantListItem>? = nil, endSession: Bool? = false) {
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
        self.hints = hints
        self.listItems = listItems
        self.endSession = endSession
    }
}
