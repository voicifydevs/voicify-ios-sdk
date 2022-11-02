//
//  CustomAssistantRequestContext.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/25/22.
//

import UIKit

public class CustomAssistantRequestContext
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
    public var additionalRequestAttributes: Dictionary<String, Any>
    public var additionalSessionAttributes: Dictionary<String, Any>
    public var additionalSessionFlags: Array<String>
    
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
