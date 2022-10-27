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
    func addPartialListener(callback: @escaping (String) -> Void)
    func addFinalResultListener (callback: @escaping (String) -> Void)
    func addErrorListener (callback: @escaping (String) -> Void)
    func startListening ()
    func stopListening ()
}
