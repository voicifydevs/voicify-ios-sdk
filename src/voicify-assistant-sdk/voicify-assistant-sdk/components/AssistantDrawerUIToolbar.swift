//
//  AssistantDrawerUIToolbar.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 12/13/22.
//

import SwiftUI
import Kingfisher

struct AssistantDrawerUIToolbar: View {
    @Binding var assistantIsOpen: Bool
    @Binding var isFullScreen: Bool
    @Binding var isUsingSpeech: Bool
    @Binding var isSpeaking: Bool
    @Binding var animationValues: Array<CGFloat>
    @Binding var assistantStateText: String
    @Binding var inputSpeech: String
    @Binding var inputText: String
    @Binding var isFinalSpeech: Bool
    @Binding var isListening: Bool
    @Binding var showPermissionAlert: Bool
    @Binding var keyboardToggled: Bool
    @Binding var messages: Array<Message>
    @Binding var hints: Array<Hint>
    public var voicifySTT: VoicifySTTProvider
    public var voicifyTTS: VoicifyTTSProivder
    public var voicifyAssistant: VoicifyAssistant
    public var headerProps: HeaderProps? = nil
    public var toolBarProps: ToolBarProps? = nil
    public var assistantSettingsProps: AssistantSettingsProps
    
    public init(assistantIsOpen: Binding<Bool>,
                isFullScreen: Binding<Bool>,
                isUsingSpeech: Binding<Bool>,
                isSpeaking: Binding<Bool>,
                animationValues: Binding<Array<CGFloat>>,
                assistatStateText: Binding<String>,
                inputSpeech: Binding<String>,
                inputText: Binding<String>,
                isFinalSpeech: Binding<Bool>,
                isListening: Binding<Bool>,
                showPermissionAlert: Binding<Bool>,
                keyboardToggled: Binding<Bool>,
                messages: Binding<Array<Message>>,
                hints: Binding<Array<Hint>>,
                voicifySTT: VoicifySTTProvider,
                voicifyTTS: VoicifyTTSProivder,
                voicifyAssistant: VoicifyAssistant,
                headerProps: HeaderProps? = nil,
                toolBarProps: ToolBarProps? = nil,
                assistantSettingsProps: AssistantSettingsProps
    ){
        self._assistantIsOpen = assistantIsOpen
        self._isFullScreen = isFullScreen
        self._isUsingSpeech = isUsingSpeech
        self._isSpeaking = isSpeaking
        self._animationValues = animationValues
        self._assistantStateText = assistatStateText
        self._inputSpeech = inputSpeech
        self._inputText = inputText
        self._isFinalSpeech = isFinalSpeech
        self._isListening = isListening
        self._showPermissionAlert = showPermissionAlert
        self._keyboardToggled = keyboardToggled
        self._messages = messages
        self._hints = hints
        self.voicifySTT = voicifySTT
        self.voicifyTTS = voicifyTTS
        self.voicifyAssistant = voicifyAssistant
        self.headerProps = headerProps
        self.toolBarProps = toolBarProps
        self.assistantSettingsProps = assistantSettingsProps
    }
    
    var body: some View {
        VStack(){
            if (!isFullScreen){
                HStack{
                    Text(toolBarProps?.helpText ?? "How can i help?")
                        .italic()
                        .font(.custom(toolBarProps?.helpTextFontFamily ?? "SF Pro" , size: CGFloat(toolBarProps?.helpTextFontSize ?? 18)))
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
                SpeakingAnimation(isSpeaking: $isSpeaking, isFullScreen: $isFullScreen, animationValues: $animationValues, equalizerColor: toolBarProps?.equalizerColor)
                HStack(){
                    Text(assistantStateText)
                        .italic()
                        .foregroundColor(Color.init(hex: toolBarProps?.assistantStateTextColor ?? "#8F97A1"))
                        .font(.custom(toolBarProps?.assistantStateFontFamily ?? "SF Pro" , size: CGFloat(toolBarProps?.assistantStateFontSize ?? 16)))
                        .accessibilityIdentifier("assistantStateText")
                    Spacer()
                }
                .padding(.bottom, -4)
                
                HStack{
                    Text(inputSpeech)
                        .font(.custom(toolBarProps?.partialSpeechResultFontFamily ?? "SF Pro", size: CGFloat( toolBarProps?.partialSpeechResultFontSize ?? 18)))
                        .foregroundColor(Color.init(hex: !isFinalSpeech ? toolBarProps?.partialSpeechResultTextColor ?? "#ffffff33" : toolBarProps?.fullSpeechResultTextColor ?? "#ffffff"))
                        .accessibilityIdentifier("inputSpeechText")
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
                if assistantSettingsProps.useVoiceInput {
                    Text("SPEAK")
                        .font(.custom(toolBarProps?.speakFontFamily ?? "SF Pro" , size: CGFloat(toolBarProps?.speakFontSize ?? 14)))
                        .foregroundColor(Color.init(hex: isUsingSpeech ? toolBarProps?.speakActiveTitleColor ?? "#3E77A5" : toolBarProps?.speakInactiveTitleColor ?? "#8F97A1"))
                        .accessibilityIdentifier("speakText")
                }
                Text("TYPE")
                    .font(.custom(toolBarProps?.typeFontFamily ?? "SF Pro" , size: CGFloat(toolBarProps?.typeFontSize ?? 14)))
                    .foregroundColor(Color.init(hex: isUsingSpeech ? toolBarProps?.typeInactiveTitleColor  ?? "#8F97A1" : toolBarProps?.typeActiveTitleColor ?? "#3E77A5"))
                    .padding(.leading, 8)
                Spacer()
            }
            HStack{
                if assistantSettingsProps.useVoiceInput {
                    Button(action: {
                        UIApplication.shared.endEditing()
                        isUsingSpeech = true
                        if(isListening)
                        {
                            voicifySTT.stopListening()
                            isListening = false
                            inputSpeech = ""
                            assistantStateText = "I didn't catch that..."
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
                    })
                    {
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
                    .alert(isPresented: $showPermissionAlert) {
                        Alert(title: Text("Permission Denied"),
                              message: Text("You do not have permission to use speech recognition. Go to your app settings to grant permission and then try again.")
                        )
                    }
                    .accessibilityIdentifier("micButton")
                    Spacer()
                }
                HStack{
                    TextField(toolBarProps?.placeholder ?? "Enter a message...", text: $inputText){focused in
                        if(focused){
                            isUsingSpeech = false
                            keyboardToggled.toggle()
                        }
                        if(isListening)
                        {
                            isListening = false
                            inputSpeech = ""
                        }
                    }
                    .font(.custom(toolBarProps?.textboxFontFamily ?? "SF Pro" , size: CGFloat(toolBarProps?.textBoxFontSize ?? 16)))
                    .padding(.leading, 10)
                    .overlay(VStack{Divider().background(Color(hex: toolBarProps?.textInputLineColor ?? "#000000")).offset(x: 0, y: 15)}.padding(.leading, 10))
                    .accentColor(Color.init(hex: toolBarProps?.textInputCursorColor ?? "#000000"))
                    .foregroundColor(Color.init(hex: toolBarProps?.textInputTextColor ?? "#000000"))
                    .accessibilityIdentifier("messageInputField")
                    Button(action:{
                        if !inputText.isEmpty {
                            UIApplication.shared.endEditing()
                            messages.append(Message(id: UUID().uuidString, text: inputText, origin: "Sent"))
                            voicifyAssistant.makeTextRequest(text: inputText, inputType: "text")
                            inputText = ""
                            hints = []
                        }
                    }){
                        KFImage(URL(string: isUsingSpeech ? toolBarProps?.sendInactiveImage ?? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/0c5aa61c-7d6c-4272-abd2-75d9f5771214/Send-2-.png":
                                        toolBarProps?.sendActiveImage ?? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/7a39bc6f-eef5-4185-bcf8-2a645aff53b2/Send-3-.png"))
                        .resizable()
                        .frame(width: CGFloat(toolBarProps?.sendImageWidth ?? 28), height: CGFloat(toolBarProps?.sendImageHeight ?? 28))
                        
                    }
                    .accessibilityIdentifier("sendButton")
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
        .onChange(of: isListening){ _ in
            if(isListening == false)
            {
                voicifySTT.stopListening()
            }
        }
    }
}
