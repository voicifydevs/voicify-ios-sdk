//
//  AssistantDrawerUI.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 11/3/22.
//

//https://www.youtube.com/watch?v=uVBjgFHaysY

import SwiftUI
import BottomSheet
import Kingfisher
public struct AssistantDrawerUI: View {
    var assistantSettingsProps: AssistantSettingsProps
    @Binding var assistantIsOpen: Bool
    @State var isFullScreen: Bool = false
    @State var height = UIScreen.main.bounds.height/2.2
    @State var inputText = ""
    @StateObject var voicifySTT = VoicifySTTProvider()
    @StateObject var voicifyTTS = VoicifyTTSProivder(settings: VoicifyTextToSpeechSettings(appId: "99a803b7-5b37-426c-a02e-63c8215c71eb", appKey: "MTAzM2RjNDEtMzkyMC00NWNhLThhOTYtMjljMDc3NWM5NmE3", voice: "", serverRootUrl: "https://assistant.voicify.com", provider: "Google"))
    @StateObject var voicifyAsssitant = VoicifyAssistant(
        speechToTextProvider: VoicifySTTProvider(),
        textToSpeechProivder: VoicifyTTSProivder(
            settings: VoicifyTextToSpeechSettings(
                appId: "99a803b7-5b37-426c-a02e-63c8215c71eb",
                appKey: "MTAzM2RjNDEtMzkyMC00NWNhLThhOTYtMjljMDc3NWM5NmE3",
                voice: "",
                serverRootUrl: "https://assistant.voicify.com",
                provider: "Google"
            )
        ),
        settings: VoicifyAssistantSettings(
            serverRootUrl: "https://assistant.voicify.com",
            appId: "99a803b7-5b37-426c-a02e-63c8215c71eb",
            appKey: "MTAzM2RjNDEtMzkyMC00NWNhLThhOTYtMjljMDc3NWM5NmE3",
            locale: "en-US",
            channel: "test",
            device: "test",
            autoRunConversation: true,
            initializeWithWelcomeMessage: false,
            initializeWithText: true,
            useVoiceInput: true,
            useDraftContent: false,
            useOutputSpeech: true,
            noTracking: false
        )
    )
    @State var inputSpeech = ""
    @State var speechVolume: Float = 0
    @State var isListening = false
    @State var isSpeaking = true
    @State var speechEndedMessage = ""
    @State var responseText = ""

    public init(assistantSettings: AssistantSettingsProps, assistantIsOpen: Binding<Bool>) {
        self.assistantSettingsProps = assistantSettings
        self._assistantIsOpen = assistantIsOpen
    }
    
    public var body: some View {
        BottomSheet(isPresented: $assistantIsOpen, height: isFullScreen ? UIScreen.main.bounds.height : UIScreen.main.bounds.height/2.2, topBarHeight: 0 , showTopIndicator: false){
            VStack(){
                Text(responseText)
                HStack{
                    Text("How can i help?")
                        .italic()
                        .foregroundColor(Color.init(hex: "#8F97A1"))
                    Spacer()
                    KFImage(URL(string: "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/a6de04bb-e572-4a55-8cd9-1a7628285829/delete-2.png"))
                }
                .padding(.bottom, 30)
                .padding(.top, 0)
                HStack(){
                    Text(isListening ? "Listening..." : "")
                        .italic()
                        .foregroundColor(Color.init(hex: "#8F97A1"))
                    Spacer()
                }
               
                Text(inputSpeech)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .background(Color.init(hex: "#00000080"))
                
                Divider().frame(maxWidth: .infinity)
                    .padding(.top, 20)
                
                HStack{
                    Text("SPEAK")
                    Text("TYPE")
                }
                .padding(.top, 10)
                .padding(.trailing, 230)
                HStack{
                    Button(action: {
                        if(isListening)
                        {
                            voicifySTT.stopListening()
                        }
                        else{
                            voicifySTT.startListening()
                        }
                           }) {
                               KFImage(URL(string: isListening ? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/daca643f-6730-4af5-8817-8d9d0d9db0b5/mic-image.png" : "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/3f10b6d7-eb71-4427-adbc-aadacbe8940e/mic-image-1-.png"))
                           }
                    TextField("TextInput", text: $inputText)
                        .padding(.leading, 20)
                        .overlay(VStack{Divider().offset(x: 0, y: 15)}.padding(.leading, 20))
                }
                .padding(.top, 10)
                
            }
            .padding(.horizontal, 20)
            .padding(.top, 0)
        }
        .onChange(of: assistantIsOpen){ _ in
            if(assistantIsOpen == true){
                print("opened")
                inputSpeech = ""
                responseText = ""
                    voicifySTT.initialize(locale: "en-US")
                    voicifyTTS.initialize(locale: "en-US")
                    voicifyTTS.addFinishListener {() -> Void in
                        speechEndedMessage = "speech has ended"
                    }
                    voicifySTT.addFinalResultListener{(fullResult: String) -> Void  in
                        inputSpeech = fullResult
                        isSpeaking = false
                        voicifyAsssitant.makeTextRequest(text: fullResult, inputType: "Speak")
                    }
                    voicifySTT.addPartialListener{(partialResult:String) -> Void in
                        inputSpeech = partialResult
                    }
                    voicifySTT.addVolumeListener{(volume: Float) -> Void in
                        speechVolume = volume
                    }
                    voicifySTT.addStartListener {
                        isListening = true
                        inputSpeech = ""
                        responseText = ""
                    }
                    voicifySTT.addEndListener {
                        isListening = false
                    }
                voicifyAsssitant.onResponseReceived{response in
                    responseText = response.displayText
//                    print("we are here")
//                    inputSpeech = ""
//                    isFull = true
                }
                voicifyAsssitant.startNewSession()
                voicifyAsssitant.initializeAndStart()
                voicifySTT.startListening()
            }
            else{
                voicifySTT.stopListening()
                voicifyTTS.stop()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, opacity: a)
    }
}
