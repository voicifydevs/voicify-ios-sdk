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
                headerProps: nil
//                    HeaderProps(
//                        fontSize: 16,
//                        backgroundColor: "#345671",
//                        assistantImage: "https://media.istockphoto.com/id/1141495869/photo/3d-render-blue-pink-neon-round-frame-circle-ring-shape-empty-space-ultraviolet-light-80s.jpg?s=612x612&w=0&k=20&c=s_k3XrnKy9qRzTR2vdLg_BC6smrY1WymKpBsBfAvLNU=",
//                        assistantImageBackgroundColor: "#00000000",
//                        assistantImageHeight: 80,
//                        assistantImageWidth: 80,
//                        assistantName: "Im Your Assistant",
//                        assistantNameTextColor: "#ffffff",
//                        assistantImageBorderRadius: 0,
//                        assistantImageBorderColor: "#000000",
//                        assistantImageBorderWidth: 5,
//                        closeAssistantButtonImage: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Xbox_button_X.svg/2048px-Xbox_button_X.svg.png",
//                        closeAssistantButtonImageHeight: 80,
//                        closeAssistantButtonImageWidth: 80,
//                        closeAssistantButtonBorderRadius: 200,
//                        closeAssistantButtonBackgroundColor: "#ffffff",
//                        closeAssistantButtonBorderWidth: 15,
//                        closeAssistantButtonBorderColor: "#000000",
//                        paddingLeft: 20,
//                        paddingRight: 20,
//                        paddingTop: 40,
//                        paddingBottom: 20
//                    )
                ,
                bodyProps: nil
//                    BodyProps(
//                        backgroundColor: "#345671",
//                        assistantImageBorderColor: "#000000",
//                        borderWidth: 1,
//                        assistantImageBorderWidth: 2,
//                        assistantImageBorderRadius: 0,
//                        assistantImage: "https://media.istockphoto.com/id/1141495869/photo/3d-render-blue-pink-neon-round-frame-circle-ring-shape-empty-space-ultraviolet-light-80s.jpg?s=612x612&w=0&k=20&c=s_k3XrnKy9qRzTR2vdLg_BC6smrY1WymKpBsBfAvLNU=",
//                        assistantImageHeight: 35,
//                        assistantImageWidth: 35,
//                        assistantImageBackgroundColor: "#000000",
//                        messageSentTextColor: "#00ffff",
//                        messageSentBackgroundColor: "#ffffff",
//                        messageReceivedFontSize: 18,
//                        messageReceivedTextColor: "#ffffff",
//                        messageReceivedBackgroundColor: "00ffff",
//                        messageSentFontSize: 18,
//                        messageSentBorderWidth: 5,
//                        messageSentBorderColor: "#000000",
//                        messageReceivedBorderWidth: 5,
//                        messageReceivedBorderColor: "#ffffff",
//                        messageSentBorderTopLeftRadius: 10,
//                        messageSentBorderTopRightRadius: 0,
//                        messageSentBorderBottomLeftRadius: 10,
//                        messageSentBorderBottomRightRadius: 10,
//                        messageReceivedBorderTopLeftRadius: 0,
//                        messageReceivedBorderTopRightRadius: 10,
//                        messageReceivedBorderBottomLeftRadius: 10,
//                        messageReceivedBorderBottomRightRadius: 10,
//                        paddingLeft: 20,
//                        paddingRight: 20,
//                        paddingTop: 20,
//                        paddingBottom: 20,
//                        borderColor: "#ffffff",
//                        hintsTextColor: "#00ffff",
//                        hintsFontSize: 20,
//                        hintsPaddingTop: 15,
//                        hintsPaddingBottom: 15,
//                        hintsPaddingRight: 15,
//                        hintsPaddingLeft: 15,
//                        hintsBackgroundColor: "#000000",
//                        hintsBorderWidth: 1,
//                        hintsBorderColor: "#ffffff",
//                        hintsBorderRadius: 0
//                    )
                ,
                toolBarProps: nil
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
//                    paddingBottom: 80,
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
        .ignoresSafeArea(.container)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
