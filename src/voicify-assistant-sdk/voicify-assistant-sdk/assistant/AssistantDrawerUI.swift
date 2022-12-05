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
    @State var hints: Array<Hint> = []
    @State var isFullScreen: Bool = false
    @State var height = UIScreen.main.bounds.height/2.2
    @State var inputText = ""
    var voicifySTT: VoicifySTTProvider
    var voicifyTTS: VoicifyTTSProivder
    var voicifyAsssitant: VoicifyAssistant
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
        voicifySTT = VoicifySTTProvider()
        voicifyTTS = VoicifyTTSProivder(settings: VoicifyTextToSpeechSettings(appId: assistantSettings.appId, appKey: assistantSettings.appKey, voice: assistantSettings.voice, serverRootUrl: assistantSettings.serverRootUrl, provider: assistantSettings.textToSpeechProvider))
        voicifyAsssitant = VoicifyAssistant(speechToTextProvider: voicifySTT, textToSpeechProvider: voicifyTTS, settings: VoicifyAssistantSettings(serverRootUrl: assistantSettings.serverRootUrl, appId: assistantSettings.appId, appKey: assistantSettings.appKey, locale: assistantSettings.locale, channel: assistantSettings.channel, device: assistantSettings.device, autoRunConversation: assistantSettings.autoRunConversation, initializeWithWelcomeMessage: assistantSettings.initializeWithWelcomeMessage, initializeWithText: assistantSettings.initializeWithText, useVoiceInput: assistantSettings.useVoiceInput, useDraftContent: assistantSettings.useDraftContent, useOutputSpeech: assistantSettings.useOutputSpeech, noTracking: assistantSettings.noTracking))
    }
    
    public var body: some View {
        BottomSheet(isPresented: $assistantIsOpen, height: assistantSettingsProps.initializeWithWelcomeMessage && !isFullScreen ? 0 : isFullScreen ? UIScreen.main.bounds.height : !isUsingSpeech ? UIScreen.main.bounds.height/3.5 : UIScreen.main.bounds.height/2.2, topBarHeight: 0 , showTopIndicator: false){
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
                Spacer()
                if isFullScreen {
                    VStack{
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
                                                Spacer()
                                            }
                                            VStack{
                                                Text(message.text)
                                                    .foregroundColor(Color.init(hex:"#000000"))
                                                    .font(.system(size: 14))
                                                    .padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6))
                                                    .background(Color.init(hex: "#0000000d"))
                                                    .overlay(RoundedRectangle(cornerRadius: CGFloat(0)).stroke(Color.init(hex: "#8F97A1")!, lineWidth: 1))
                                            }
                                            .padding(.top, 20)
                                            Spacer()
                                        }
                                        .padding(.trailing, 40)
                                        .padding(.top, 10)
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
                                        .padding(.leading, 50)
                                        .padding(.top, 30)
                                    }
                                }
                                Spacer()
                            }
                            .padding(.top, 20) //body padding here
                            .padding(.bottom, 10) // basline padding is 50, add the props padding to it
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                        }
                        if !hints.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack{
                                    ForEach(hints){hint in
                                        VStack{
                                            Button(action:{
                                                UIApplication.shared.endEditing()
                                                inputText = ""
                                                inputSpeech = ""
                                                voicifySTT.stopListening()
                                                voicifyTTS.stop()
                                                messages.append(Message(text: hint.text, origin: "Sent"))
                                                voicifyAsssitant.makeTextRequest(text: hint.text, inputType: "Text")
                                                hints = []
                                            }){
                                                Text(hint.text)
                                                    .lineLimit(1)
                                                    .font(.system(size: 14))
                                                    .foregroundColor(Color.init(hex: "#000000"))
                                                    .padding(.leading, 8)
                                                    .padding(.trailing, 8)
                                                    .padding(.top, 8)
                                                    .padding(.bottom, 8)
                                                    .background(Color.init(hex: "#ffffff"))
                                                    .cornerRadius(CGFloat(20))
                                                    .overlay(RoundedRectangle(cornerRadius: CGFloat(20)).inset(by: CGFloat(1)).stroke(Color.init(hex: "#CCCCCC")!, lineWidth: 1.5))
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.bottom, 10)
                            .padding(.leading, 10)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .border(Color.init(hex: "#8F97A1")!)
                    .background(Color.init(hex: "#F4F4F6"))
                }
                VStack(){
                    if isUsingSpeech{
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
                       
                    }
                    if isUsingSpeech || (!isFullScreen && !isUsingSpeech){
                        Line()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [3]))
                            .padding(.top, (isFullScreen || isUsingSpeech) ? 15 : 0)
                            .foregroundColor(Color.init(hex: "#8F97A1"))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    HStack{
                        VStack{
                            Text("SPEAK")
                                .font(.system(size: 14))
                                .foregroundColor(Color.init(hex: isUsingSpeech ? "#3E77A5" : "#8F97A1"))
                                .padding(.bottom, 10)
                            Button(action: {
                                UIApplication.shared.endEditing()
                                isUsingSpeech = true
                                if(isListening)
                                {
                                    voicifySTT.stopListening()
                                    inputSpeech = ""
                                }
                                else{
                                    voicifySTT.startListening()
                                }
                                   }) {
                                       VStack{
                                           KFImage(URL(string: isUsingSpeech ? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/daca643f-6730-4af5-8817-8d9d0d9db0b5/mic-image.png" : "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/3f10b6d7-eb71-4427-adbc-aadacbe8940e/mic-image-1-.png"))
                                       }
                                       .padding(.all, 4)
                                       .background(Color.init(hex: isListening && isUsingSpeech ? "#1e7eb91f" : "00000000"))
                                       .cornerRadius(CGFloat(40))
                                   }
                        }
                        VStack{
                            HStack{
                                Text("TYPE")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.init(hex: isUsingSpeech ? "#8F97A1" : "#3E77A5"))
                                Spacer()
                            }
                            HStack{
                                TextField("TextInput", text: $inputText){focused in
                                    if(focused){
                                        isUsingSpeech = false
                                    }
                                    voicifySTT.stopListening()
                                }
                                .padding(.leading, 10)
                                .overlay(VStack{Divider().offset(x: 0, y: 15)}.padding(.leading, 10))
                                Button(action:{
                                    if !inputText.isEmpty {
                                        UIApplication.shared.endEditing()
                                        messages.append(Message(text: inputText, origin: "Sent"))
                                        voicifyAsssitant.makeTextRequest(text: inputText, inputType: "text")
                                        inputText = ""
                                        hints = []
                                    }
                                }){
                                    KFImage(URL(string: isUsingSpeech ? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/0c5aa61c-7d6c-4272-abd2-75d9f5771214/Send-2-.png": "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/7a39bc6f-eef5-4185-bcf8-2a645aff53b2/Send-3-.png"))
                                }
                            }
                            .padding(.top, 22)
                            .padding(.bottom, 10)
                            .padding(.trailing, 10)
                            .background(Color.init(hex: !isUsingSpeech ? "#1e7eb91f" : "00000000"))
                            .cornerRadius(CGFloat(10))
                        }
                        .padding(.leading, 6)
                    }
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
            }
            .padding(.top, isFullScreen ? 40 : 10) //if full screen, use header props top padding, otherwise use tool bar props top padding
            .padding(.bottom, isFullScreen ? 20: 10) //if full screen, use header props top padding, otherwise use tool bar props top padding
        }
        .onChange(of: assistantIsOpen){ _ in
            if(assistantIsOpen == true){
                voicifyAsssitant.ClearHandlers()
                voicifySTT.clearHandlers()
                voicifyAsssitant.initializeAndStart()
                voicifyAsssitant.onEffect(effectName: "closeAssistant"){data in
                    print("WE GOT THE CLOSE EFFECT")
                }
                voicifyAsssitant.onEffect(effectName: "Play"){data in
                    print("WE GOT THE PLAY EFFECT")
                }
                inputSpeech = ""
                responseText = ""
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
                    hints = []
                    voicifyAsssitant.makeTextRequest(text: fullResult, inputType: "Speech")
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
                    isFullScreen = true
                    response.hints.forEach{ hint in
                        hints.append(Hint(text: hint))
                    }
                    messages.append(Message(text: response.displayText.trimmingCharacters(in: .whitespacesAndNewlines), origin: "Received"))
                    print("RESPONSE RECEIVED!!!")
                }
                voicifyAsssitant.startNewSession()
                if(assistantSettingsProps.initializeWithWelcomeMessage)
                {
                    if(assistantSettingsProps.initializeWithText == false)
                    {
                        isUsingSpeech = true
                    }
                    else{
                        isUsingSpeech = false
                    }
                }
                else if (assistantSettingsProps.initializeWithText == false){
                    voicifySTT.startListening()
                    isUsingSpeech = true
                }
                else{
                    isUsingSpeech = false
                }
            }
            else{
                UIApplication.shared.endEditing()
                messages = []
                isFullScreen = false
                voicifySTT.stopListening()
                voicifyTTS.stop()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .padding(.bottom, 0.1) // if keyboard is active - causes view to lift
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

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
