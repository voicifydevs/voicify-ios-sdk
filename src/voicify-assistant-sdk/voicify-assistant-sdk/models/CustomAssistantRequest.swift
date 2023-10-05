//
//  CustomAssistantRequest.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/25/22.
//

import UIKit

public class CustomAssistantRequest : Codable
{
    public var requestId: String
    public var context: CustomAssistantRequestContext
    public var device: CustomAssistantDevice
    public var user: CustomAssistantUser
    
    public init(requestId: String, context: CustomAssistantRequestContext, device: CustomAssistantDevice, user: CustomAssistantUser) {
        self.requestId = requestId
        self.context = context
        self.device = device
        self.user = user
    }
}
