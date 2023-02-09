//
//  ConfigurationAssistantStyle.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 1/26/23.
//

public class ConfigurationAssistantStyle: Codable
{
    public var height: String? = nil
    public var width: String? = nil
    public var zIndex: String? = nil
    public var borderRadius: String? = nil
    public var backgroundColor: String? = nil
    
    public init(height: String? = nil, width: String? = nil, zIndex: String? = nil, borderRadius: String? = nil, backgroundColor: String? = nil) {
        self.height = height
        self.width = width
        self.zIndex = zIndex
        self.borderRadius = borderRadius
        self.backgroundColor = backgroundColor
    }
}

