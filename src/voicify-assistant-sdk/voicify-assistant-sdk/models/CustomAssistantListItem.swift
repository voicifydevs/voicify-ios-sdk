//
//  CustomAssistantListItem.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/25/22.
//

import UIKit

public class CustomAssistantListItem
{
    public var id: String
    public var title: String
    public var description: String
    public var image: String
    
    public init(id: String, title: String, description: String, image: String) {
        self.id = id
        self.title = title
        self.description = description
        self.image = image
    }
}
