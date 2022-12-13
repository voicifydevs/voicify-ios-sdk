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
    var headerProps: HeaderProps? = nil
    var bodyProps: BodyProps? = nil
    var toolBarProps: ToolBarProps? = nil
    var voicifySTT: VoicifySTTProvider
    var voicifyTTS: VoicifyTTSProivder
    var voicifyAsssitant: VoicifyAssistant
    @Binding var assistantIsOpen: Bool
    @State var messages: Array<Message> = []
    @State var hints: Array<Hint> = []
    @State var isFullScreen: Bool = false
    @State var height = UIScreen.main.bounds.height/2.2
    @State var inputText = ""
    @State var inputSpeech = " "
    @State var speechVolume: Float = 0
    @State var isListening = false
    @State var isSpeaking = false
    @State var responseText = ""
    @State var isUsingSpeech = true
    @State var animationValues: Array<CGFloat> = [CGFloat](repeating: 0.0001, count: 8)
    @State var assistantStateText = " "
    @State var isFinalSpeech = false
    @State var keyboardToggled = false
    @State var showPermissionAlert = false

    public init(assistantSettings: AssistantSettingsProps, headerProps: HeaderProps?, bodyProps: BodyProps?, toolBarProps: ToolBarProps?) {
        self.assistantSettingsProps = assistantSettings
        self.headerProps = headerProps
        self.bodyProps = bodyProps
        self.toolBarProps = toolBarProps
        self._assistantIsOpen = assistantSettingsProps.assistantIsOpen
        voicifySTT = VoicifySTTProvider()
        voicifyTTS = VoicifyTTSProivder(settings: VoicifyTextToSpeechSettings(appId: assistantSettings.appId, appKey: assistantSettings.appKey, voice: assistantSettings.voice, serverRootUrl: assistantSettings.serverRootUrl, provider: assistantSettings.textToSpeechProvider))
        voicifyAsssitant = VoicifyAssistant(speechToTextProvider: voicifySTT, textToSpeechProvider: voicifyTTS, settings: VoicifyAssistantSettings(serverRootUrl: assistantSettings.serverRootUrl, appId: assistantSettings.appId, appKey: assistantSettings.appKey, locale: assistantSettings.locale, channel: assistantSettings.channel, device: assistantSettings.device, autoRunConversation: assistantSettings.autoRunConversation, initializeWithWelcomeMessage: assistantSettings.initializeWithWelcomeMessage, initializeWithText: assistantSettings.initializeWithText, useVoiceInput: assistantSettings.useVoiceInput, useDraftContent: assistantSettings.useDraftContent, useOutputSpeech: assistantSettings.useOutputSpeech, noTracking: assistantSettings.noTracking))
    }
    
    public var body: some View {
        BottomSheet(isPresented: $assistantIsOpen, height: assistantSettingsProps.initializeWithWelcomeMessage && !isFullScreen ? 0 : isFullScreen ? UIScreen.main.bounds.height : !isUsingSpeech ? CGFloat(toolBarProps?.drawerTextHeight ?? 220) : CGFloat(toolBarProps?.drawerSpeechHeight ?? 330), topBarHeight: 0 , showTopIndicator: false){
            VStack(spacing: 0){
                if isFullScreen {
                    HStack{
                        VStack{
                            KFImage(URL(string: headerProps?.assistantImage ?? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/eb7d2538-a3dc-4304-b58c-06fdb34e9432/Mark-Color-3-.png"))
                                .resizable()
                                .frame(width: CGFloat(headerProps?.assistantImageWidth ?? 32), height: CGFloat(headerProps?.assistantImageHeight ?? 32))
                                .fixedSize()
                        }
                        .padding(.all, 4)
                        .overlay(RoundedRectangle(cornerRadius: CGFloat(headerProps?.assistantImageBorderRadius ?? 20)).stroke(Color.init(hex: headerProps?.assistantImageBorderColor ?? "#8F97A1")!, lineWidth: CGFloat(headerProps?.assistantImageBorderWidth ?? 2)))
                        .background(Color.init(hex: headerProps?.assistantImageBackgroundColor ?? "#ffffff"))
                        .cornerRadius(CGFloat(headerProps?.assistantImageBorderRadius ?? 20))
                        
                        Text(headerProps?.assistantName ?? "Voicify Assistant")
                            .font(.system(size: CGFloat(headerProps?.fontSize ?? 18)))
                            .foregroundColor(Color.init(hex: headerProps?.assistantNameTextColor ?? "#000000"))
                            .padding(.leading, 4)
                        
                        Spacer()
                        
                        Button(action: {
                            assistantIsOpen = false
                        }){
                            KFImage(URL(string: headerProps?.closeAssistantButtonImage ?? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/a6de04bb-e572-4a55-8cd9-1a7628285829/delete-2.png"))
                                .resizable()
                                .padding(.all, 4)
                                .overlay(RoundedRectangle(cornerRadius: CGFloat(headerProps?.closeAssistantButtonBorderRadius ?? 0)).stroke(Color.init(hex: headerProps?.closeAssistantButtonBorderColor ?? "#00000000")!, lineWidth: CGFloat(headerProps?.closeAssistantButtonBorderWidth ?? 0)))
                                .frame(width: CGFloat(headerProps?.closeAssistantButtonImageWidth ?? 35), height: CGFloat(headerProps?.closeAssistantButtonImageHeight ?? 35))
                                .background(Color.init(hex: headerProps?.closeAssistantButtonBackgroundColor ?? "#00000000"))
                                .cornerRadius(CGFloat(headerProps?.closeAssistantButtonBorderRadius ?? 0))
                        }
                    }
                    .padding(.leading, CGFloat(headerProps?.paddingLeft ?? 20))
                    .padding(.trailing, CGFloat(headerProps?.paddingRight ?? 20))
                    .padding(.top, CGFloat(headerProps?.paddingTop ?? 50))
                    .padding(.bottom, CGFloat(headerProps?.paddingBottom ?? 20))
                    .background(Color(hex: headerProps?.backgroundColor ?? "#ffffff"))
                    VStack{
                        ScrollViewReader{ value in
                            ScrollView{
                                VStack{
                                    ForEach(messages){ message in
                                        if message.origin == "Received"{
                                            HStack{
                                                VStack{
                                                    KFImage(URL(string: bodyProps?.assistantImage ?? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/eb7d2538-a3dc-4304-b58c-06fdb34e9432/Mark-Color-3-.png"))
                                                        .resizable()
                                                        .padding(.all, 4)
                                                        .overlay(RoundedRectangle(cornerRadius: CGFloat(bodyProps?.assistantImageBorderRadius ?? 20)).stroke(Color.init(hex: bodyProps?.assistantImageBorderColor ?? "#8F97A1")!, lineWidth: CGFloat(bodyProps?.assistantImageBorderWidth ?? 2)))
                                                        .frame(width: CGFloat(bodyProps?.assistantImageWidth ?? 35), height: CGFloat(bodyProps?.assistantImageHeight ?? 35))
                                                        .background(Color.init(hex: bodyProps?.assistantImageBackgroundColor ?? "#ffffff"))
                                                        .cornerRadius(CGFloat(bodyProps?.assistantImageBorderRadius ?? 20))
                                                    Spacer()
                                                }
                                                VStack{
                                                    Text(.init(message.text) )
                                                        .foregroundColor(Color.init(hex: bodyProps?.messageReceivedTextColor ?? "#000000"))
                                                        .font(.system(size: CGFloat(bodyProps?.messageReceivedFontSize ?? 14)))
                                                        .padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6))
                                                        .background(RoundedCorners(tl: CGFloat(bodyProps?.messageReceivedBorderTopLeftRadius ?? 0), tr: CGFloat(bodyProps?.messageReceivedBorderTopRightRadius ?? 10), bl: CGFloat(bodyProps?.messageReceivedBorderBottomLeftRadius ?? 10), br: CGFloat(bodyProps?.messageReceivedBorderBottomRightRadius ?? 10)).stroke(Color.init(hex: bodyProps?.messageReceivedBorderColor ?? "#8F97A1")!, lineWidth: CGFloat(bodyProps?.messageReceivedBorderWidth ?? 1)))
                                                        .background(RoundedCorners(tl: CGFloat(bodyProps?.messageReceivedBorderTopLeftRadius ?? 0), tr: CGFloat(bodyProps?.messageReceivedBorderTopRightRadius ?? 10), bl: CGFloat(bodyProps?.messageReceivedBorderBottomLeftRadius ?? 10), br: CGFloat(bodyProps?.messageReceivedBorderBottomRightRadius ?? 10)).fill(Color.init(hex: bodyProps?.messageReceivedBackgroundColor ?? "#0000000d")!))
                                                }
                                                .padding(.top, 20)
                                                Spacer()
                                            }
                                            .padding(.trailing, 40)
                                            .padding(.top, 10)
                                            .id(message.id)
                                        }
                                        else{
                                            HStack{
                                                Spacer()
                                                Text(message.text)
                                                    .font(.system(size: CGFloat(bodyProps?.messageSentFontSize ?? 14)))
                                                    .foregroundColor(Color.init(hex:bodyProps?.messageSentTextColor ?? "#ffffff"))
                                                    .padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6))
                                                    .background(RoundedCorners(tl: CGFloat(bodyProps?.messageSentBorderTopLeftRadius ?? 8), tr: CGFloat(bodyProps?.messageSentBorderTopRightRadius ?? 0), bl: CGFloat(bodyProps?.messageSentBorderBottomLeftRadius ?? 8), br: CGFloat(bodyProps?.messageSentBorderBottomRightRadius ?? 8)).stroke(Color.init(hex: bodyProps?.messageSentBorderColor ?? "#00000000")!, lineWidth: CGFloat(bodyProps?.messageReceivedBorderWidth ?? 0)))
                                                    .background(RoundedCorners(tl: CGFloat(bodyProps?.messageSentBorderTopLeftRadius ?? 8), tr: CGFloat(bodyProps?.messageSentBorderTopRightRadius ?? 0), bl: CGFloat(bodyProps?.messageSentBorderBottomLeftRadius ?? 8), br: CGFloat(bodyProps?.messageSentBorderBottomRightRadius ?? 8)).fill(Color.init(hex: bodyProps?.messageSentBackgroundColor ?? "#00000080")!))
                                            }
                                            .padding(.leading, 50)
                                            .padding(.top, 30)
                                        }
                                    }
                                }
                                .padding(.top, CGFloat(bodyProps?.paddingTop ?? 20))
                                .padding(.bottom, CGFloat(bodyProps?.paddingBottom ?? 10))
                                .padding(.leading, CGFloat(bodyProps?.paddingLeft ?? 20))
                                .padding(.trailing, CGFloat(bodyProps?.paddingRight ?? 20))
                            }
                            .onChange(of: messages.count, perform: { _ in
                                    if(messages[messages.count - 1].origin == "Received")
                                    {
                                        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in
                                            value.scrollTo(messages[messages.count - 1].id)
                                        }
                                    }
                                }
                            )
                            .onChange(of: isUsingSpeech, perform: { _ in
                                    if(messages[messages.count - 1].origin == "Received")
                                    {
                                        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in
                                            value.scrollTo(messages[messages.count - 1].id, anchor: .bottom)
                                        }
                                    }
                                }
                            )
                            .onChange(of: keyboardToggled, perform: { _ in
                                    if(messages[messages.count - 1].origin == "Received")
                                    {
                                        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in
                                            value.scrollTo(messages[messages.count - 1].id, anchor: .bottom)
                                        }
                                    }
                                }
                            )
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
                                                messages.append(Message(id: UUID().uuidString,text: hint.text, origin: "Sent"))
                                                voicifyAsssitant.makeTextRequest(text: hint.text, inputType: "Text")
                                                hints = []
                                            }){
                                                Text(hint.text)
                                                    .lineLimit(1)
                                                    .font(.system(size: CGFloat(bodyProps?.hintsFontSize ?? 14)))
                                                    .foregroundColor(Color.init(hex: bodyProps?.hintsTextColor ?? "#000000"))
                                                    .padding(.leading, CGFloat(bodyProps?.hintsPaddingLeft ?? 8))
                                                    .padding(.trailing, CGFloat(bodyProps?.hintsPaddingRight ?? 8))
                                                    .padding(.top, CGFloat(bodyProps?.hintsPaddingTop ?? 8))
                                                    .padding(.bottom, CGFloat(bodyProps?.hintsPaddingBottom ?? 8))
                                                    .background(Color.init(hex: bodyProps?.hintsBackgroundColor ?? "#ffffff"))
                                                    .cornerRadius(CGFloat(bodyProps?.hintsBorderRadius ?? 20))
                                                    .overlay(RoundedRectangle(cornerRadius: CGFloat(bodyProps?.hintsBorderRadius ?? 20)).strokeBorder(Color.init(hex: bodyProps?.hintsBorderColor ?? "#CCCCCC")!, lineWidth: CGFloat(bodyProps?.hintsBorderWidth ?? 1.5)))
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
                    .border(width: CGFloat(bodyProps?.borderTopWidth ?? 1), edges: [.top], color: Color.init(hex: bodyProps?.borderTopColor ?? "#8F97A1")!)
                    .border(width: CGFloat(bodyProps?.borderBottomWidth ?? 1), edges: [.bottom], color: Color.init(hex: bodyProps?.borderBottomColor ?? "#8F97A1")!)
                    .background(Color.init(hex: bodyProps?.backgroundColor ?? "#F4F4F6"))
                }
                VStack(){
                    if (!isFullScreen){
                        HStack{
                            Text(toolBarProps?.helpText ?? "How can i help?")
                                .italic()
                                .font(.system(size: CGFloat(toolBarProps?.helpTextFontSize ?? 18)))
                                .foregroundColor(Color.init(hex: toolBarProps?.helpTextFontColor ?? "#8F97A1"))
                            Spacer()
                            Button(action: {
                                assistantIsOpen = false
                            }){
                                KFImage(URL(string: headerProps?.closeAssistantButtonImage ?? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/a6de04bb-e572-4a55-8cd9-1a7628285829/delete-2.png"))
                                    .resizable()
                                    .padding(.all, 4)
                                    .overlay(RoundedRectangle(cornerRadius: CGFloat(headerProps?.closeAssistantButtonBorderRadius ?? 0)).stroke(Color.init(hex: headerProps?.closeAssistantButtonBorderColor ?? "#00000000")!, lineWidth: CGFloat(headerProps?.closeAssistantButtonBorderWidth ?? 0)))
                                    .frame(width: CGFloat(headerProps?.closeAssistantButtonImageWidth ?? 35), height: CGFloat(headerProps?.closeAssistantButtonImageHeight ?? 35))
                                    .background(Color.init(hex: headerProps?.closeAssistantButtonBackgroundColor ?? "#00000000"))
                                    .cornerRadius(CGFloat(headerProps?.closeAssistantButtonBorderRadius ?? 0))
                            }
                        }
                        Spacer()
                    }
                    if isUsingSpeech{
                        HStack{
                            VStack{
                                
                            }
                            .frame(width: 4, height: 1)
                            .background(Color.init(hex: toolBarProps?.equalizerColor ?? "#00000080"))
                            .scaleEffect(x: 1, y: isSpeaking ? animationValues[0] * 5 : 1, anchor: .bottom)
                            .padding(.trailing, -10)
                            VStack{
                                
                            }
                            .frame(width: 4, height: 1)
                            .background(Color.init(hex: toolBarProps?.equalizerColor ?? "#00000080"))
                            .scaleEffect(x: 1, y: isSpeaking ? animationValues[1] * 10 : 1, anchor: .bottom)
                            .padding(.trailing, -10)
                            VStack{
                                
                            }
                            .frame(width: 4, height: 1)
                            .background(Color.init(hex: toolBarProps?.equalizerColor ?? "#00000080"))
                            .scaleEffect(x: 1, y: isSpeaking ? animationValues[2] * 11 : 1, anchor: .bottom)
                            .padding(.trailing, -10)
                            VStack{
                                
                            }
                            .frame(width: 4, height: 1)
                            .background(Color.init(hex: toolBarProps?.equalizerColor ?? "#00000080"))
                            .scaleEffect(x: 1, y: isSpeaking ? animationValues[3] * 13 : 1, anchor: .bottom)
                            .padding(.trailing, -10)
                            VStack{
                                
                            }
                            .frame(width: 4, height: 1)
                            .background(Color.init(hex: toolBarProps?.equalizerColor ?? "#00000080"))
                            .scaleEffect(x: 1, y: isSpeaking ? animationValues[4] * 13 : 1, anchor: .bottom)
                            .padding(.trailing, -10)
                            VStack{
                                
                            }
                            .frame(width: 4, height: 1)
                            .background(Color.init(hex: toolBarProps?.equalizerColor ?? "#00000080"))
                            .scaleEffect(x: 1, y: isSpeaking ? animationValues[5] * 11 : 1, anchor: .bottom)
                            .padding(.trailing, -10)
                            VStack{
                                
                            }
                            .frame(width: 4, height: 1)
                            .background(Color.init(hex: toolBarProps?.equalizerColor ?? "#00000080"))
                            .scaleEffect(x: 1, y: isSpeaking ? animationValues[6] * 10 : 1, anchor: .bottom)
                            .padding(.trailing, -10)
                            VStack{
                                
                            }
                            .frame(width: 4, height: 1)
                            .background(Color.init(hex: toolBarProps?.equalizerColor ?? "#00000080"))
                            .scaleEffect(x: 1, y: isSpeaking ? animationValues[7] * 5 : 1, anchor: .bottom)
                        }
                        .frame(minHeight: 10)
                        .padding(.top, isFullScreen ? 36 : 0)
                        HStack(){
                            Text(assistantStateText)
                                .italic()
                                .foregroundColor(Color.init(hex: toolBarProps?.assistantStateTextColor ?? "#8F97A1"))
                                .font(.system(size: CGFloat(toolBarProps?.assistantStateFontSize ?? 16)))
                            Spacer()
                        }
                        .padding(.bottom, -4)
                        
                        HStack{
                            Text(inputSpeech)
                                .foregroundColor(Color.init(hex: !isFinalSpeech ? toolBarProps?.partialSpeechResultTextColor ?? "#ffffff33" : toolBarProps?.fullSpeechResultTextColor ?? "#ffffff"))
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .padding(.horizontal, 8)
                        .background(Color.init(hex: toolBarProps?.speechResultBoxBackgroundColor ?? "#00000080"))
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
                        Text("SPEAK")
                            .font(.system(size: CGFloat(toolBarProps?.speakFontSize ?? 14)))
                            .foregroundColor(Color.init(hex: isUsingSpeech ? toolBarProps?.speakActiveTitleColor ?? "#3E77A5" : toolBarProps?.speakInactiveTitleColor ?? "#8F97A1"))
                        Text("TYPE")
                            .font(.system(size: CGFloat(toolBarProps?.typeFontSize ?? 14)))
                            .foregroundColor(Color.init(hex: isUsingSpeech ? toolBarProps?.typeInactiveTitleColor  ?? "#8F97A1" : toolBarProps?.typeActiveTitleColor ?? "#3E77A5"))
                            .padding(.leading, 8)
                        Spacer()
                    }
                    HStack{
                        Button(action: {
                            UIApplication.shared.endEditing()
                            isUsingSpeech = true
                            if(isListening)
                            {
                                voicifySTT.stopListening()
                                isListening = false
                                inputSpeech = ""
                            }
                            else{
                                if(voicifySTT.hasPermission)
                                {
                                    voicifySTT.startListening()
                                    voicifyTTS.stop()
                                }
                                else{
                                    showPermissionAlert = true
                                }
                            }
                        }) {
                               VStack{
                                   KFImage(URL(string: isUsingSpeech ? toolBarProps?.micActiveImage ?? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/daca643f-6730-4af5-8817-8d9d0d9db0b5/mic-image.png" : toolBarProps?.micInactiveImage ?? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/3f10b6d7-eb71-4427-adbc-aadacbe8940e/mic-image-1-.png"))
                                       .resizable()
                                       .frame(width: CGFloat(toolBarProps?.micImageWidth ?? 40), height: CGFloat(toolBarProps?.micImageHeight ?? 40))
                               }
                               .padding(.all, CGFloat(toolBarProps?.micImagePadding ?? 4))
                               .overlay(RoundedRectangle(cornerRadius: CGFloat(toolBarProps?.micBorderRadius ?? 40)).stroke(Color.init(hex: toolBarProps?.micImageBorderColor ?? "#8F97A1")!, lineWidth: CGFloat(toolBarProps?.micImageBorderWidth ?? 0)))
                               .background(Color.init(hex: isListening && isUsingSpeech ? toolBarProps?.micActiveHighlightColor ?? "#1e7eb91f" : toolBarProps?.micInactiveHighlightColor ?? "00000000"))
                               .cornerRadius(CGFloat(toolBarProps?.micBorderRadius ?? 40))
                            }
                            .frame(minWidth: 44, minHeight: 44)
                            .alert("You do not have permission to use speech recognition. Go to your app settings to grant permission and then try again.", isPresented: $showPermissionAlert) {
                                Button("OK", role: .cancel) { }
                            }
                        Spacer()
                        HStack{
                            TextField(toolBarProps?.placeholder ?? "Enter a message...", text: $inputText){focused in
                                if(focused){
                                    isUsingSpeech = false
                                    keyboardToggled.toggle()
                                }
                                voicifySTT.stopListening()
                                isListening = false
                            }
                            .font(.system(size: CGFloat(toolBarProps?.textBoxFontSize ?? 16)))
                            .padding(.leading, 10)
                            .overlay(VStack{Divider().background(Color(hex: toolBarProps?.textInputLineColor ?? "#000000")).offset(x: 0, y: 15)}.padding(.leading, 10))
                            .accentColor(Color.init(hex: toolBarProps?.textInputCursorColor ?? "#000000"))
                            .foregroundColor(Color.init(hex: toolBarProps?.textInputTextColor ?? "#000000"))
                            Button(action:{
                                if !inputText.isEmpty {
                                    UIApplication.shared.endEditing()
                                    messages.append(Message(id: UUID().uuidString, text: inputText, origin: "Sent"))
                                    voicifyAsssitant.makeTextRequest(text: inputText, inputType: "text")
                                    inputText = ""
                                    hints = []
                                }
                            }){
                                KFImage(URL(string: isUsingSpeech ? toolBarProps?.sendInactiveImage ?? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/0c5aa61c-7d6c-4272-abd2-75d9f5771214/Send-2-.png":
                                                toolBarProps?.sendActiveImage ?? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/7a39bc6f-eef5-4185-bcf8-2a645aff53b2/Send-3-.png"))
                                .resizable()
                                .frame(width: CGFloat(toolBarProps?.sendImageWidth ?? 28), height: CGFloat(toolBarProps?.sendImageHeight ?? 28))
                                
                            }
                        }
                        .padding(.top, 22)
                        .padding(.bottom, 10)
                        .padding(.trailing, 10)
                        .background(Color.init(hex: !isUsingSpeech ? toolBarProps?.textBoxActiveHighlightColor ?? "#1e7eb91f" : toolBarProps?.textBoxInactiveHighlightColor ?? "00000000"))
                        .cornerRadius(CGFloat(10))
                    }
                            
                }
                .padding(.leading, CGFloat(toolBarProps?.paddingLeft ?? 20))
                .padding(.trailing, CGFloat(toolBarProps?.paddingRight ?? 20))
                .padding(.bottom, CGFloat(toolBarProps?.paddingBottom ?? 20))
                .padding(.top, CGFloat(toolBarProps?.paddingTop ?? 10))
                .background(Color(hex: toolBarProps?.backgroundColor ?? "#ffffff"))
            }
        }
        .onChange(of: assistantIsOpen){ _ in
            if(assistantIsOpen == true){
                voicifyTTS.cancelSpeech = false
                voicifySTT.cancel = false
                voicifyAsssitant.ClearHandlers()
                voicifySTT.clearHandlers()
                voicifyAsssitant.initializeAndStart()
                inputSpeech = ""
                responseText = ""
                voicifySTT.addPartialListener{(partialResult:String) -> Void in
                    inputSpeech = partialResult
                }
                voicifySTT.addFinalResultListener{(fullResult: String) -> Void  in
                    isFinalSpeech = true
                    assistantStateText = " "
                    inputSpeech = fullResult
                    voicifyAsssitant.makeTextRequest(text: inputSpeech, inputType: "Speech")
                }
                voicifySTT.addVolumeListener{(volume: Float) -> Void in
                    for i in 0...7 {
                        let value = CGFloat.random(in: 0...CGFloat(volume))
                        animationValues[i] = value
                    }
                    if isSpeaking == false{
                        isSpeaking = true
                    }
                }
                voicifySTT.addStartListener {
                    isListening = true
                    isFinalSpeech = false
                    assistantStateText = "Listening..."
                }
                voicifySTT.addEndListener {
                    if(isListening){
                        isListening = false
                        isSpeaking = false
                        if(inputSpeech.isEmpty)
                        {
                            assistantStateText = "I didn't catch that..."
                        }
                        else {
                            assistantStateText = " "
                        }
                        for i in 0...7 {
                            animationValues[i] = CGFloat(1)
                        }
                    }
                }
                voicifyAsssitant.onRequestStarted{request in
                    
                }
                voicifyAsssitant.onResponseReceived{response in
                    if(!inputSpeech.isEmpty)
                    {
                        messages.append(Message(id: UUID().uuidString,text: inputSpeech, origin: "Sent"))
                        inputSpeech = ""
                    }
                    isFullScreen = true
                    hints = []
                    response.hints.forEach{ hint in
                        hints.append(Hint(text: hint))
                    }
                    messages.append(Message(id: UUID().uuidString,text: response.displayText.trimmingCharacters(in: .whitespacesAndNewlines), origin: "Received"))
                }
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
                    if(voicifySTT.hasPermission)
                    {
                        voicifySTT.startListening()
                        isUsingSpeech = true
                    }
                }
                else{
                    isUsingSpeech = false
                }
                assistantSettingsProps.effects.forEach{effect in
                    voicifyAsssitant.onEffect(effectName: effect){data in
                        assistantSettingsProps.onEffect(effect, data)
                    }
                }
                voicifyAsssitant.startNewSession()
            }
            else{
                UIApplication.shared.endEditing()
                messages = []
                voicifyTTS.cancelSpeech = true
                voicifySTT.cancel = true
                isFullScreen = false
                voicifySTT.stopListening()
                voicifyTTS.stop()
                voicifyTTS.clearHandlers()
                voicifySTT.clearHandlers()
                voicifyAsssitant.ClearHandlers()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .padding(.bottom, assistantIsOpen ? 0.1 : 0) // if keyboard is active - causes view to lift
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

struct RoundedCorners: Shape {
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let w = rect.size.width
        let h = rect.size.height
        
        // Make sure we do not exceed the size of the rectangle
        let tr = min(min(self.tr, h/2), w/2)
        let tl = min(min(self.tl, h/2), w/2)
        let bl = min(min(self.bl, h/2), w/2)
        let br = min(min(self.br, h/2), w/2)
        
        path.move(to: CGPoint(x: w / 2.0, y: 0))
        path.addLine(to: CGPoint(x: w - tr, y: 0))
        path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr,
                    startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
        
        path.addLine(to: CGPoint(x: w, y: h - br))
        path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        
        path.addLine(to: CGPoint(x: bl, y: h))
        path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl,
                    startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        
        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
                    startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        
        path.addLine(to: CGPoint(x: w/2.0, y: 0))
        path.closeSubpath()

        return path
    }
}

struct EdgeBorder: Shape {

    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }

            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }

            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return self.width
                }
            }

            var h: CGFloat {
                switch edge {
                case .top, .bottom: return self.width
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
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
