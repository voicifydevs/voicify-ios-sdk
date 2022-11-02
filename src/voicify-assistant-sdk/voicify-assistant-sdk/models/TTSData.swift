//
//  TTSData.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/26/22.
//

import UIKit

public class TTSData : Decodable
{
    public var rootElementType: String
    public var url: String
    
    public init(rootElementType: String, url: String) {
        self.rootElementType = rootElementType
        self.url = url
    }
}
