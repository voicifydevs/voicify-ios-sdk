//
//  CustomAssistantRequestContext.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/25/22.
//

import UIKit

public class CustomAssistantRequestContext
{
    var sessionId: String
    var noTracking: Bool
    var requestType: String
    var requestName: String
    var slots: Dictionary<String, String>
    var originialInput: String
    var channel: String
    var requiresLanguageUnderstanding: Bool
    var locale: String
    var additionalRequestAttributes: Dictionary<String, Any>
    var additionalSessionAttributes: Dictionary<String, Any>
    var additionalSessionFlags: Array<String>
    
    public init(sessionId: String, noTracking: Bool? = false, requestType: String, requestName: String? = nil, slots: Dictionary<String, String>? = nil, originialInput: String, channel: String, requiresLanguageUnderstanding: Bool, locale: String, additionalRequestAttributes: Dictionary<String, Any>, additionalSessionAttributes: Dictionary<String, Any>, additionalSessionFlags: Array<String>? = []) {
        self.sessionId = sessionId
        self.noTracking = noTracking ?? false
        self.requestType = requestType
        self.requestName = requestName ?? ""
        self.slots = slots ?? [:]
        self.originialInput = originialInput
        self.channel = channel
        self.requiresLanguageUnderstanding = requiresLanguageUnderstanding
        self.locale = locale
        self.additionalRequestAttributes = additionalRequestAttributes
        self.additionalSessionAttributes = additionalSessionAttributes
        self.additionalSessionFlags = additionalSessionFlags ?? []
    }
}
