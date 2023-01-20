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
        
        if (effectName == "Navigate"){
            print(data["page"])
            print("navigated")
        }
    }
    
    func onClose () -> Void {
        print("We Closed")
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
             assistantSettings: AssistantSettingsProps(
              serverRootUrl: "https://dev-assistant.voicify.com",
              appId: "bc9fa6bf-6cea-4fad-af12-d388b64dbdb9",
              appKey: "ZjcyNmNkNjEtNmY5My00NTg3LWI5ZmQtMjJkNzE3NGMwYTI4",
              locale: "en-US",
              channel: "My App",
              device: "My device",
              textToSpeechVoice: "",
              autoRunConversation: false,
              initializeWithWelcomeMessage: true,
              textToSpeechProvider: "Google",
              useVoiceInput: true,
              useOutputSpeech: true,
              useDraftContent: false,
              noTracking: true,
              initializeWithText: false,
              backgroundColor: "#202C36,#3E77A5"
            ),
            headerProps: HeaderProps(
              backgroundColor: "#00000000",
              assistantName: "Age App",
              assistantNameTextColor: "#FFFFFF",
              fontFamily: "Muli",
              closeAssistantColor: "#FFFFFF"
            ),
            bodyProps: BodyProps(
              backgroundColor: "#00000000",
              messageSentTextColor: "#FFFFFF",
              messageSentBackgroundColor: "#3E77A5",
              messageReceivedTextColor: "#FFFFFF",
              messageReceivedBackgroundColor: nil,
              messageSentFontFamily: "Muli",
              messageReceivedFontFamily: "Muli",
              hintsTextColor: "#FFFFFF",
              hintsBackgroundColor: "#00000000",
              hintsFontFamily: "Muli"
            ),
            toolBarProps: ToolBarProps(
              backgroundColor: "#00000000",
              speakActiveTitleColor: "#FFFFFF",
              speakInactiveTitleColor: "#FFFFFF",
              typeActiveTitleColor: "#FFFFFF",
              typeInactiveTitleColor: "#FFFFFF",
              partialSpeechResultTextColor: "#FFFFFF",
              fullSpeechResultTextColor: "#FFFFFF",
              speechResultBoxBackgroundColor: "#3E77A5",
              textInputTextColor: "#FFFFFF",
              helpTextFontColor: "#FFFFFF",
              partialSpeechResultFontFamily: "Muli",
              assistantStateFontFamily: "Muli",
              helpTextFontFamily: "Muli",
              speakFontFamily: "Muli",
              typeFontFamily: "Muli",
              textboxFontFamily: "Muli",
              equalizerColor: "#ffffffb3,#ffffffb3",
              micActiveColor: "#FFFFFF",
              sendActiveColor: "#FFFFFF",
              sendInactiveColor: "#FFFFFF",
              assistantStateTextColor: "#FFFFFF"
             )
            )
            .ignoresSafeArea(.container)
        }
    }
}
