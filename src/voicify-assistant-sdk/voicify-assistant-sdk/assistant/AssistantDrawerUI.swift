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
    @State var messages: Array<Message> = []
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
    @State var inputSpeech = " "
    @State var speechVolume: Float = 0
    @State var isListening = false
    @State var isSpeaking = true
    @State var speechEndedMessage = ""
    @State var responseText = ""
    @State var isUsingSpeech = true

    public init(assistantSettings: AssistantSettingsProps, assistantIsOpen: Binding<Bool>) {
        self.assistantSettingsProps = assistantSettings
        self._assistantIsOpen = assistantIsOpen
    }
    
    public var body: some View {
        BottomSheet(isPresented: $assistantIsOpen, height: assistantSettingsProps.initializeWithWelcomeMessage && !isFullScreen ? 0 : isFullScreen ? UIScreen.main.bounds.height : UIScreen.main.bounds.height/2.2, topBarHeight: 0 , showTopIndicator: false){
            VStack(){
                HStack{
                    if isFullScreen{
                        VStack{
                            KFImage(URL(string: "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/eb7d2538-a3dc-4304-b58c-06fdb34e9432/Mark-Color-3-.png"))
                                .resizable()
                                .frame(width: CGFloat(32), height: CGFloat(32))
                                .fixedSize()
                        }
                        .padding(.all, 4)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.init(hex: "#8F97A1")!, lineWidth: 2))
                        .background(Color.init(hex: "#ffffff"))
                        .cornerRadius(CGFloat(20))
                        Text("Voicify Assistant")
                            .font(.system(size: 18))
                            .foregroundColor(Color.init(hex: "#000000"))
                            .padding(.leading, 4)
                    }
                    else
                    {
                        Text("How can i help?")
                            .italic()
                            .font(.system(size: 18))
                            .foregroundColor(Color.init(hex: "#8F97A1"))
                    }
                    Spacer()
                    Button(action: {
                        assistantIsOpen = false
                    }){
                        KFImage(URL(string: "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/a6de04bb-e572-4a55-8cd9-1a7628285829/delete-2.png"))
                    }
                }
                .padding(.trailing, isFullScreen ? 20 : 20) //if full screen, use header props top padding, otherwise use tool bar props top padding
                .padding(.leading, isFullScreen ? 20 : 20) //if full screen, use header props top padding, otherwise use tool bar props top padding
                .padding(.bottom, isFullScreen ? 10 : 30)
                if isFullScreen {
                        ScrollView{
                            VStack{
                                ForEach(messages){ message in
                                    if message.origin == "Received"{
                                        HStack{
                                            VStack{
                                                KFImage(URL(string: "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/eb7d2538-a3dc-4304-b58c-06fdb34e9432/Mark-Color-3-.png"))
                                                    .fixedSize()
                                                    .padding(.all, 4)
                                                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.init(hex: "#8F97A1")!, lineWidth: 2))
                                                    .background(Color.init(hex: "#ffffff"))
                                                    .cornerRadius(CGFloat(20))
                                            }
                                            VStack{
                                                Text(message.text)
                                                    .foregroundColor(Color.init(hex:"#000000"))
                                                    .font(.system(size: 14))
                                                    .padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6))
                                                    .background(Color.init(hex: "#0000000d"))
                                                    .overlay(RoundedRectangle(cornerRadius: CGFloat(0)).stroke(Color.init(hex: "#8F97A1")!, lineWidth: 1))

                                            }
                                            .padding(.bottom, -50)
                                            Spacer()
                                        }
                                    }
                                    else{
                                        HStack{
                                            Spacer()
                                            Text(message.text)
                                                .font(.system(size: 14))
                                                .foregroundColor(Color.init(hex:"#ffffff"))
                                                .padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6))
                                                .background(Color.init(hex: "#00000080"))
                                                .overlay(RoundedRectangle(cornerRadius: CGFloat(0)).stroke(Color.init(hex: "#00000000")!, lineWidth: 1))
                                        }
                                        .padding(.top, 50)
                                    }
                                }
                                Spacer()
                            }
                            .padding(.top, 20) //body padding here
                            .padding(.bottom, 60) // basline padding is 50, add the props padding to it
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .border(Color.init(hex: "#8F97A1")!)
                        .background(Color.init(hex: "#F4F4F6"))
                }
                VStack(){
                    HStack(){
                        Text(isListening ? "Listening..." : " ")
                            .italic()
                            .foregroundColor(Color.init(hex: "#8F97A1"))
                            .font(.system(size: 16))
                        Spacer()
                    }
                    .padding(.bottom, -4)
                    
                    HStack{
                        Text(inputSpeech)
                            .foregroundColor(Color.init(hex: "#ffffff"))
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .padding(.horizontal, 8)
                    .background(Color.init(hex: "#00000080"))
                    .cornerRadius(CGFloat(10))
                   
                    
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [3]))
                        .padding(.top, 20)
                        .foregroundColor(Color.init(hex: "#8F97A1"))
                        .fixedSize(horizontal: false, vertical: true)
                    
                    HStack{
                        Text("SPEAK")
                            .font(.system(size: 14))
                            .foregroundColor(Color.init(hex: isUsingSpeech ? "#3E77A5" : "#8F97A1"))
                        Text("TYPE")
                            .font(.system(size: 14))
                            .foregroundColor(Color.init(hex: isUsingSpeech ? "#8F97A1" : "#3E77A5"))
                            .padding(.leading, 12)
                        Spacer()
                    }
                    .padding(.leading, 4)
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
                                   VStack{
                                       KFImage(URL(string: isUsingSpeech ? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/daca643f-6730-4af5-8817-8d9d0d9db0b5/mic-image.png" : "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/3f10b6d7-eb71-4427-adbc-aadacbe8940e/mic-image-1-.png"))
                                   }
                                   .padding(.all, 4)
                                   .background(Color.init(hex: isListening ? "#1e7eb91f" : "00000000"))
                                   .cornerRadius(CGFloat(40))
                               }
                        TextField("TextInput", text: $inputText)
                            .padding(.leading, 20)
                            .overlay(VStack{Divider().offset(x: 0, y: 15)}.padding(.leading, 20))
                    }
                    .padding(.top, 10)
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
            }
            .padding(.top, isFullScreen ? 40 : 40) //if full screen, use header props top padding, otherwise use tool bar props top padding
            .padding(.bottom, isFullScreen ? 40: 40) //if full screen, use header props top padding, otherwise use tool bar props top padding
        }
        .onChange(of: assistantIsOpen){ _ in
            if(assistantIsOpen == true){
                print("opened")
                voicifyAsssitant.ClearHandlers()
                voicifySTT.clearHandlers()
                inputSpeech = ""
                responseText = ""
                    voicifySTT.initialize(locale: "en-US")
                    voicifyTTS.initialize(locale: "en-US")
                    voicifyTTS.addFinishListener {() -> Void in
                        speechEndedMessage = "speech has ended"
                    }
                    voicifySTT.addPartialListener{(partialResult:String) -> Void in
                        inputSpeech = partialResult
                        print("got partial result")
                    }
                    voicifySTT.addFinalResultListener{(fullResult: String) -> Void  in
                        print("got full result")
                        inputSpeech = fullResult
                        isSpeaking = false
                        messages.append(Message(text: fullResult, origin: "Sent"))
                        inputSpeech = ""
                        voicifyAsssitant.makeTextRequest(text: fullResult, inputType: "Speak")
                    }
                    voicifySTT.addVolumeListener{(volume: Float) -> Void in
                        speechVolume = volume
                    }
                    voicifySTT.addStartListener {
                        isListening = true
                    }
                    voicifySTT.addEndListener {
                        isListening = false
                    }
                voicifyAsssitant.onRequestStarted{request in
                    
                }
                voicifyAsssitant.onResponseReceived{response in
                    inputSpeech = ""
                    print(response.displayText.trimmingCharacters(in: .whitespacesAndNewlines))
                    print("we are here")
                    isFullScreen = true
                    messages.append(Message(text: response.displayText.trimmingCharacters(in: .whitespacesAndNewlines), origin: "Received"))
                }
                voicifyAsssitant.startNewSession()
                voicifyAsssitant.initializeAndStart()
                if(assistantSettingsProps.initializeWithWelcomeMessage)
                {
                    voicifyAsssitant.makeWelcomeMessage()
                }
                else if (assistantSettingsProps.initializeWithText == false){
                    voicifySTT.startListening()
                }
            }
            else{
                messages = []
                isFullScreen = false
                voicifySTT.stopListening()
                voicifyTTS.stop()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
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
