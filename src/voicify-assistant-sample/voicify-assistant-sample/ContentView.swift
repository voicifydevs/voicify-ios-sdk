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
            AssistantDrawerUI(
                assistantSettings: AssistantSettingsProps(
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
                    assistantIsOpen: $assistantIsOpen
                ),
                headerProps:
                    HeaderProps(
                        fontSize: 10,
                        backgroundColor: "345671",
                        assistantImage: nil,
                        assistantImageBackgroundColor: nil,
                        assistantName: nil,
                        assistantNameTextColor: "",
                        assistantImageBorderRadius: nil,
                        assistantImageBorderColor: nil,
                        assistantImageBorderWidth: nil,
                        closeAssistantButtonImage: nil,
                        closeAssistantButtonBorderRadius: nil,
                        closeAssistantButtonBackgroundColor: nil,
                        closeAssistantButtonBorderWidth: nil,
                        closeAssistantButtonBorderColor: nil,
                        paddingLeft: 20,
                        paddingRight: 20,
                        paddingTop: nil,
                        paddingBottom: nil
                    ),
                bodyProps: nil,
                toolBarProps:
                    nil
//                    ToolBarProps(
//                    backgroundColor: "#00ffff",
//                    micBorderRadius: 40,
//                    micImagePadding: 4,
//                    micImageBorderWidth: 0,
//                    micImageBorderColor: "#ffffff",
//                    micImageHeight: 40,
//                    micImageWidth: 40,
//                    micActiveImage: "https://www.pngfind.com/pngs/m/90-904785_png-file-svg-close-button-icon-png-transparent.png",
//                    sendImageWidth: 40,
//                    sendImageHeight: 40,
//                    micInactiveImage:"https://i5.walmartimages.com/asr/b3337795-302f-4103-8add-a83309ee9822.11e15756eb30b5a7b90580be65d28af7.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
//                    micActiveHighlightColor: "#00ffff",
//                    micInactiveHighlightColor: "#345672",
//                    sendActiveImage:"https://www.mcdonalds.com/is/image/content/dam/usa/nfl/nutrition/items/hero/desktop/t-mcdonalds-Fries-Small-Medium.jpg",
//                    sendInactiveImage: "https://thecozycook.com/wp-content/uploads/2020/02/Copycat-McDonalds-French-Fries-.jpg",
//                    speakFontSize: 14,
//                    speakActiveTitleColor: "#00ffff",
//                    speakInactiveTitleColor: "#000000",
//                    typeFontSize: 14, typeActiveTitleColor: "#00ffff",
//                    typeInactiveTitleColor: "#000000",
//                    textBoxFontSize: 16,
//                    textBoxActiveHighlightColor: "#00ffff",
//                    textBoxInactiveHighlightColor: "#345671",
//                    partialSpeechResultTextColor: "#00ffff",
//                    fullSpeechResultTextColor: "#345671",
//                    speechResultBoxBackgroundColor: "#000000",
//                    textInputLineColor: "#ffffff",
//                    textInputCursorColor: "#ffffff",
//                    textInputTextColor: "#ffffff",
//                    paddingLeft: 20,
//                    paddingRight: 20,
//                    paddingTop: 10,
//                    paddingBottom: 10,
//                    placeholder: "just enter it...",
//                    helpText: "What do you want?",
//                    helpTextFontSize: 18,
//                    helpTextFontColor: "#000000",
//                    assistantStateTextColor: "#000000",
//                    assistantStateFontSize: 16,
//                    equalizerColor: "#000000"
//                )
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
