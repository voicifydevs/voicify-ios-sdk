//
//  VoicifyEffects.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 1/17/23.
//

import Foundation

public func closeAssistantCallback (data: Dictionary<String, Any>) -> Void{
    print("closing after specified time")
    NotificationCenter.default.post(Notification(name: NSNotification.Name.closeAssistant))
}
