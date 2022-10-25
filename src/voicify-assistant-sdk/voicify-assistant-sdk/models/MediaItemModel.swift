//
//  MediaItemModel.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/25/22.
//

import UIKit

public class MediaItemModel
{
    var id: String
    var url: String

    public init(id: String, url: String) {
        self.id = id
        self.url = url
    }
}

