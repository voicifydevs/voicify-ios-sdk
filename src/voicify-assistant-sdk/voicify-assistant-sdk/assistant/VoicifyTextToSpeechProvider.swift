//
//  VoicifyTextToSpeechProvider.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/26/22.
//

import UIKit

public protocol VoicifyTextToSpeechProvider
{
    func initialize (locale: String)
    func speakSsml (ssml: String)
    func addFinishListener (callback: @escaping () -> Void)
    func clearHandlers ()
    func stop ()
}
