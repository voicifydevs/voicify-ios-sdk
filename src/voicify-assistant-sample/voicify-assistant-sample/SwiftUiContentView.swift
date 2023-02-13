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
    @State var showAssistantUnavailableAlert = false
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
        
        if (effectName == "Navigate"){
            print(data["page"])
            print("navigated")
        }
    }
    
    func onClose () -> Void {
        print("We Closed")
    }
    
    func onError (errorMessage: String, request: CustomAssistantRequest) {
        NotificationCenter.default.post(Notification(name: NSNotification.Name.closeAssistant))
        showAssistantUnavailableAlert = true
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
                    .alert(isPresented: $showAssistantUnavailableAlert) {
                    Alert(title: Text("Error"),
                          message: Text("Assistant Unavailable.")
                    )
                }
            }
            //config needed for tests
//            AssistantDrawerUI(
//                assistantSettings: AssistantSettingsProps(
//                    serverRootUrl: "https://assistant.voicify.com",
//                    appId: "99a803b7-5b37-426c-a02e-63c8215c71eb",
//                    appKey: "MTAzM2RjNDEtMzkyMC00NWNhLThhOTYtMjljMDc3NWM5NmE3",
//                    autoRunConversation: true,
//                    initializeWithWelcomeMessage: true,
//                    initializeWithText: false,
//                    effects: ["Play"],
//                    onEffect: onEffect
//                )
//            )
//            .ignoresSafeArea(.container)
            
            AssistantDrawerUI(
              assistantSettings:
               AssistantSettingsProps(
                configurationId: "10d0bfc5-7ca6-4068-a7f8-d4c738c71923",
                serverRootUrl: "https://dev-assistant.voicify.com",
                appId: "bc9fa6bf-6cea-4fad-af12-d388b64dbdb9",
                appKey: "ZjcyNmNkNjEtNmY5My00NTg3LWI5ZmQtMjJkNzE3NGMwYTI4"
               )
            )
        }
    }
}
