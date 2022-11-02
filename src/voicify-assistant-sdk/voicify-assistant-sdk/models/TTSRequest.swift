//
//  TTSRequest.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/26/22.
//

import UIKit

public class TTSRequest : Codable
{
    public var applicationId: String
    public var applicationSecret: String
    public var ssmlRequest: SsmlRequest
    
    public init(applicationId: String, applicationSecret: String, ssmlRequest: SsmlRequest) {
        self.applicationId = applicationId
        self.applicationSecret = applicationSecret
        self.ssmlRequest = ssmlRequest
    }
    
}
