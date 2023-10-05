//
//  CustomAssistantRequestContext.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/25/22.
//

import UIKit

public class CustomAssistantRequestContext : Codable
{
    public var sessionId: String
    public var noTracking: Bool
    public var requestType: String
    public var requestName: String
    public var slots: Dictionary<String, String>
    public var originialInput: String
    public var channel: String
    public var requiresLanguageUnderstanding: Bool
    public var locale: String
    public var additionalRequestAttributes: Dictionary<String, String>
    public var additionalSessionAttributes: Dictionary<String, String>
    public var additionalSessionFlags: Array<String>
    
    public init(sessionId: String, noTracking: Bool, requestType: String, requestName: String, slots: Dictionary<String, String>, originialInput: String, channel: String, requiresLanguageUnderstanding: Bool, locale: String, additionalRequestAttributes: Dictionary<String, String>, additionalSessionAttributes: Dictionary<String, String>, additionalSessionFlags: Array<String>) {
        self.sessionId = sessionId
        self.noTracking = noTracking
        self.requestType = requestType
        self.requestName = requestName
        self.slots = slots
        self.originialInput = originialInput
        self.channel = channel
        self.requiresLanguageUnderstanding = requiresLanguageUnderstanding
        self.locale = locale
        self.additionalRequestAttributes = additionalRequestAttributes
        self.additionalSessionAttributes = additionalSessionAttributes
        self.additionalSessionFlags = additionalSessionFlags
    }
}
