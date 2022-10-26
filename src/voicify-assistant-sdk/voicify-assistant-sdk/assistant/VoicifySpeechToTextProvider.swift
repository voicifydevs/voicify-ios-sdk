//
//  VoicifySpeechToTextProvider.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/26/22.
//

import UIKit

public protocol VoicifySpeechToTextProvider
{
    func initialize(locale: String)
    func addPartialListener(callback: (String) -> Void)
    func addFinalResultListener (callback: (String) -> Void)
    func addErrorListener (callback: (String) -> Void)
    func startListening ()
    func stopListening ()
}
