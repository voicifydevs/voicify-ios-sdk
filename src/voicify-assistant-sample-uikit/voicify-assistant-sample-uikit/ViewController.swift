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
    lazy var contentView = UIHostingController(
        rootView: AssistantDrawerUI(
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
    )
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let button = UIButton(frame: CGRect(x: 200, y: 60, width: 150, height: 50))
        button.backgroundColor = UIColor.blue
        button.setTitle("Open Assistant", for: .normal)
        button.addTarget(self, action: #selector(openAssistantClicked), for: .touchUpInside)
        contentView.view.frame = view.bounds
        contentView.view.tag = 100
        contentView.didMove(toParent: self)
        addChild(contentView)
        view.addSubview(contentView.view)
        view.addSubview(button)
    }
    
    @objc func openAssistantClicked(sender: UIButton!){
        NotificationCenter.default.post(Notification(name: Notification.Name("openAssistant")))
        
    }
}
