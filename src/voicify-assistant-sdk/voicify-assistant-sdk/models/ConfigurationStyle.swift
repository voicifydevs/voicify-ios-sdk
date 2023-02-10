//
//  ConfigurationStyle.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 1/26/23.
//

public class ConfigurationStyles: Codable
{
    public var assistant: ConfigurationAssistantStyle
    public var body: BodyProps
    public var toolbar: ToolbarProps
    public var header: HeaderProps
    
    public init(assistant: ConfigurationAssistantStyle, body: BodyProps, toolbar: ToolbarProps, header: HeaderProps) {
        self.assistant = assistant
        self.body = body
        self.toolbar = toolbar
        self.header = header
    }
}
