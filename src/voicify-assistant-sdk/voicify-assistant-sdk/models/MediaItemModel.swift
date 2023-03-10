//
//  MediaItemModel.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/25/22.
//

import UIKit

public class MediaItemModel
{
    public var id: String
    public var url: String
    public var name: String

    public init(id: String, url: String, name: String) {
        self.id = id
        self.url = url
        self.name = name
    }
}

