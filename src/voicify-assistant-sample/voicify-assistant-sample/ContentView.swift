//
//  ContentView.swift
//  voicify-assistant-sample
//
//  Created by Alex Dunn on 5/10/22.
//

import SwiftUI
import voicify_assistant_sdk
struct ContentView: View {
    @State var assistantIsOpen = false
    @State var currentSongTitle = ""
    func onEffect (effectName: String, data: Dictionary<String, Any>) -> Void{
        if(effectName == "Play")
        {
            if let songTitle = data["title"] as? String{
                print(songTitle)
                currentSongTitle = songTitle
            }
            assistantIsOpen = false
        }
        if(effectName == "closeAssistant")
        {
            assistantIsOpen = false
        }
    }
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    if !currentSongTitle.isEmpty {Text("Now Playing \(currentSongTitle)")}
                    Spacer()
                    Button("Click me to open \nthe assistant"){
                        self.assistantIsOpen.toggle()
                    }
                }
                Spacer()
            }
            AssistantDrawerUI(assistantSettings: AssistantSettingsProps(serverRootUrl: "https://assistant.voicify.com", appId: "99a803b7-5b37-426c-a02e-63c8215c71eb", appKey: "MTAzM2RjNDEtMzkyMC00NWNhLThhOTYtMjljMDc3NWM5NmE3", locale: "en-US", channel: "My App", device: "My Device", voice: "", autoRunConversation: true, initializeWithWelcomeMessage: false, textToSpeechProvider: "Polly", useVoiceInput: true, useOutputSpeech: true, initializeWithText: false, useDraftContent: false, noTracking: false, effects: ["Play", "closeAssistant"], onEffect: onEffect ), assistantIsOpen: $assistantIsOpen)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
