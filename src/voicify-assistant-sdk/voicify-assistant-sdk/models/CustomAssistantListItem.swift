//
//  CustomAssistantListItem.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/25/22.
//

import UIKit

public class CustomAssistantListItem : Decodable
{
    var id: String
    var title: String
    var description: String
    var image: String
    
    public init(id: String, title: String, description: String, image: String) {
        self.id = id
        self.title = title
        self.description = description
        self.image = image
    }
}
