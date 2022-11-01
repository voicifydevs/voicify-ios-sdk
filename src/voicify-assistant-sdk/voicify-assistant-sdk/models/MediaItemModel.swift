//
//  MediaItemModel.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/25/22.
//

import UIKit

public class MediaItemModel
{
    var id: String?
    var url: String?
    var name: String?

    public init(id: String? = nil, url: String? = nil, name: String? = nil) {
        self.id = id
        self.url = url
        self.name = name
    }
}

