//
//  TTSRequest.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/26/22.
//

import UIKit

public class TTSRequest
{
    var applicationId: String
    var applicationSecret: String
    var ssmlRequest: SsmlRequest
    
    public init(applicationId: String, applicationSecret: String, ssmlRequest: SsmlRequest) {
        self.applicationId = applicationId
        self.applicationSecret = applicationSecret
        self.ssmlRequest = ssmlRequest
    }
    
}
