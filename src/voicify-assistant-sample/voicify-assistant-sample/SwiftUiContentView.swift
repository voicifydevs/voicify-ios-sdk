//
//  ContentView.swift
//  voicify-assistant-sample
//
//  Created by Alex Dunn on 5/10/22.
//

import SwiftUI
import voicify_assistant_sdk

struct SwiftUiContentView: View {
    @State var assistantIsOpen = false
    @State var currentSongTitle = ""
    func onEffect (effectName: String, data: Dictionary<String, Any>) -> Void{
        if(effectName == "Play")
        {
            if let songTitle = data["title"] as? String{
                print(songTitle)
                currentSongTitle = songTitle
            }
            NotificationCenter.default.post(Notification(name: NSNotification.Name.closeAssistant))
        }
        if(effectName == "closeAssistant")
        {
            NotificationCenter.default.post(Notification(name: NSNotification.Name.closeAssistant))
        }
    }
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    if !currentSongTitle.isEmpty {Text("Now Playing \(currentSongTitle)").accessibilityIdentifier("songTitleText")}
                    Spacer()
                    Button("Click me to open \nthe assistant"){
                        NotificationCenter.default.post(Notification(name: NSNotification.Name.openAssistant))
                    }
                    .accessibilityIdentifier("openAssistantButton")
                }
                .padding(.top, 50)
                Spacer()
            }
            AssistantDrawerUI(
                assistantSettings:
                    AssistantSettingsProps(
                        serverRootUrl: "https://assistant.voicify.com",
                        appId: "99a803b7-5b37-426c-a02e-63c8215c71eb",
                        appKey: "MTAzM2RjNDEtMzkyMC00NWNhLThhOTYtMjljMDc3NWM5NmE3",
                        locale: "en-US",
                        channel: "My App",
                        device: "My Device",
                        textToSpeechVoice: "male|ar-XA-Standard-C",
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
                headerProps: HeaderProps(fontFamily: "Times New Roman")
                ,
                bodyProps: BodyProps(messageSentFontFamily: "Times New Roman",
                                     messageReceivedFontFamily: "Times New Roman",
                                     hintsFontFamily: "Times New Roman")
                ,
                toolBarProps: ToolBarProps(partialSpeechResultFontFamily: "Times New Roman",
                                           assistantStateFontFamily: "Times New Roman",
                                          helpTextFontFamily: "Times New Roman",
                                          speakFontFamily: "Times New Roman",
                                          typeFontFamily: "Times New Roman",
                                          textboxFontFamily: "Times New Roman")
            )
            .ignoresSafeArea(.container)
        }
    }
}
