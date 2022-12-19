//
//  ViewController.swift
//  voicify-assistant-sample-uikit
//
//  Created by James McCarthy on 12/16/22.
//

import UIKit
import SwiftUI
import voicify_assistant_sdk

class ViewController: UIViewController {
//    @State var assistantIsOpen = false
    func onEffect (effectName: String, data: Dictionary<String, Any>) -> Void{
        if(effectName == "Play")
        {
            if let songTitle = data["title"] as? String{
                print(songTitle)
            }
            NotificationCenter.default.post(Notification(name: Notification.Name("closeAssistant")))
        }
        if(effectName == "closeAssistant")
        {
            NotificationCenter.default.post(Notification(name: Notification.Name("closeAssistant")))
        }
    }
    
    lazy var assistantDrawerUIView = UIHostingController(
        rootView:
            AnyView(
                ZStack{
                    AssistantViewRepresentable()
                    AssistantDrawerUI(
                        assistantSettings:
                            AssistantSettingsProps(
                                serverRootUrl: "https://assistant.voicify.com",
                                appId: "99a803b7-5b37-426c-a02e-63c8215c71eb",
                                appKey: "MTAzM2RjNDEtMzkyMC00NWNhLThhOTYtMjljMDc3NWM5NmE3",
                                locale: "en-US",
                                channel: "My App",
                                device: "My Device",
                                voice: "",
                                autoRunConversation: true,
                                initializeWithWelcomeMessage: false,
                                textToSpeechProvider: "Google",
                                useVoiceInput: true,
                                useOutputSpeech: true,
                                initializeWithText: false,
                                useDraftContent: false,
                                noTracking: false,
                                effects: ["Play", "closeAssistant"],
                                onEffect: onEffect,
                                sessionAttributes: ["sessionData": "sessionData"]
                            ),
                        headerProps: nil,
                        bodyProps: nil,
                        toolBarProps: nil
                    )
                    .ignoresSafeArea(.container)
                }
            )
        )
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(assistantDrawerUIView)
        assistantDrawerUIView.view.frame = view.bounds
        view.addSubview(assistantDrawerUIView.view)
    }
    
    
}

