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
    @Binding var equalizerGradientColors: Array<Color>
    @State var toolbarParameters: ToolbarParameters = ToolbarParameters()
    @EnvironmentObject var configurationToolbarProps: ConfigurationToolbarProps
    @EnvironmentObject var configurationHeaderProps: ConfigurationHeaderProps
    @EnvironmentObject var configurationSettingsProps: ConfigurationSettingsProps
    public var voicifySTT: VoicifySTTProvider
    public var voicifyTTS: VoicifyTTSProivder
    public var voicifyAssistant: VoicifyAssistant
    public var headerProps: HeaderProps? = nil
    public var toolbarProps: ToolbarProps? = nil
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
                equalizerGradientColors: Binding<Array<Color>>,
                voicifySTT: VoicifySTTProvider,
                voicifyTTS: VoicifyTTSProivder,
                voicifyAssistant: VoicifyAssistant,
                headerProps: HeaderProps? = nil,
                toolbarProps: ToolbarProps? = nil,
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
        self._equalizerGradientColors = equalizerGradientColors
        self.voicifySTT = voicifySTT
        self.voicifyTTS = voicifyTTS
        self.voicifyAssistant = voicifyAssistant
        self.headerProps = headerProps
        self.toolbarProps = toolbarProps
        self.assistantSettingsProps = assistantSettingsProps
    }
    
    var body: some View {
        VStack(){
            if (!isFullScreen){
                HStack{
                    Text(toolbarProps?.helpText ?? configurationToolbarProps.helpText ?? "How can i help?")
                        .italic()
                        .font(.custom(toolbarParameters.helpFont , size: CGFloat(toolbarParameters.helpFontSize)))
                        .foregroundColor(Color.init(hex: toolbarParameters.helpForegroundColor))
                    Spacer()
                    Button(action: {
                        assistantIsOpen = false
                    }){
                        KFImage(URL(string: headerProps?.closeAssistantButtonImage ?? configurationHeaderProps.closeAssistantButtonImage ?? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/a6de04bb-e572-4a55-8cd9-1a7628285829/delete-2.png"))
                            .resizable()
                            .renderingMode(!(headerProps?.closeAssistantColor ?? configurationHeaderProps.closeAssistantColor ?? "").isEmpty ? .template : .none)
                            .foregroundColor(Color.init(hex: headerProps?.closeAssistantColor ?? configurationHeaderProps.closeAssistantColor ?? ""))
                            .padding(.all, 4)
                            .overlay(RoundedRectangle(cornerRadius: CGFloat(headerProps?.closeAssistantButtonBorderRadius ?? configurationHeaderProps.closeAssistantButtonBorderRadius ?? 0)).stroke(Color.init(hex: headerProps?.closeAssistantButtonBorderColor ?? configurationHeaderProps.closeAssistantButtonBorderColor ?? "#00000000")!, lineWidth: CGFloat(headerProps?.closeAssistantButtonBorderWidth ?? configurationHeaderProps.closeAssistantButtonBorderWidth ?? 0)))
                            .frame(width: CGFloat(headerProps?.closeAssistantButtonImageWidth ?? configurationHeaderProps.closeAssistantButtonImageWidth ?? 35), height: CGFloat(headerProps?.closeAssistantButtonImageHeight ?? configurationHeaderProps.closeAssistantButtonImageHeight ?? 35))
                            .background(Color.init(hex: headerProps?.closeAssistantButtonBackgroundColor ?? configurationHeaderProps.closeAssistantButtonBackgroundColor ?? "#00000000"))
                            .cornerRadius(CGFloat(headerProps?.closeAssistantButtonBorderRadius ?? configurationHeaderProps.closeAssistantButtonBorderRadius ?? 0))
                    }
                }
                Spacer()
            }
            if isUsingSpeech{
                SpeakingAnimation(isSpeaking: $isSpeaking, isFullScreen: $isFullScreen, animationValues: $animationValues, equalizerColor: toolbarProps?.equalizerColor, equalizerGradientColors: $equalizerGradientColors)
                HStack(){
                    Text(assistantStateText)
                        .italic()
                        .foregroundColor(Color.init(hex: toolbarParameters.assistantStateForegroundColor))
                        .font(.custom(toolbarParameters.assistantStatefont , size: CGFloat(toolbarParameters.assistantStateFontSize)))
                        .accessibilityIdentifier("assistantStateText")
                    Spacer()
                }
                .padding(.bottom, -4)
                
                HStack{
                    Text(inputSpeech)
                        .font(.custom(toolbarParameters.inputSpeechStatefont, size: CGFloat( toolbarParameters.inputSpeechFontSize)))
                        .foregroundColor(Color.init(hex: !isFinalSpeech ? toolbarParameters.inputSpeechPartialForegroundColor : toolbarParameters.inputSpeechFinalForegroundColor))
                        .accessibilityIdentifier("inputSpeechText")
                    Spacer()
                }
                .frame(maxWidth: .infinity, minHeight: 40)
                .padding(.horizontal, 8)
                .background(Color.init(hex: toolbarProps?.speechResultBoxBackgroundColor ?? configurationToolbarProps.speechResultBoxBackgroundColor ?? "#00000080"))
                .cornerRadius(CGFloat(10))
               
            }
            if isUsingSpeech || (!isFullScreen && !isUsingSpeech){
                Line()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [3]))
                    .padding(.top, (isFullScreen || isUsingSpeech) ? 15 : 0)
                    .foregroundColor(Color.init(hex: "cbccd2"))
                    .fixedSize(horizontal: false, vertical: true)
            }
            HStack{
                if assistantSettingsProps.useVoiceInput ?? true {
                    Text("SPEAK")
                        .font(.custom(toolbarParameters.speakFont, size: CGFloat(toolbarParameters.speakFontSize)))
                        .foregroundColor(Color.init(hex: isUsingSpeech ? toolbarParameters.speakActiveForegroundColor : toolbarParameters.speakInactiveForegroundColor))
                        .accessibilityIdentifier("speakText")
                }
                Text("TYPE")
                    .font(.custom(toolbarParameters.typeFont, size: CGFloat(toolbarParameters.typeFontSize)))
                    .foregroundColor(Color.init(hex: isUsingSpeech ? toolbarParameters.typeInactiveForegroundColor : toolbarProps?.typeActiveTitleColor ?? toolbarParameters.typeActiveForegroundColor))
                    .padding(.leading, 8)
                Spacer()
            }
            HStack{
                if assistantSettingsProps.useVoiceInput ?? true {
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
                            if isUsingSpeech {
                                KFImage(URL(string: toolbarProps?.micActiveImage ?? configurationToolbarProps.micActiveImage ?? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/daca643f-6730-4af5-8817-8d9d0d9db0b5/mic-image.png"))
                                    .resizable()
                                    .renderingMode((!(toolbarProps?.micActiveColor ?? configurationToolbarProps.micActiveColor ?? "").isEmpty) ? .template : .none)
                                    .foregroundColor(Color.init(hex: toolbarProps?.micActiveColor ?? configurationToolbarProps.micActiveColor ?? ""))
                                    .frame(width: CGFloat(toolbarProps?.micImageWidth ?? configurationToolbarProps.micImageWidth ?? 40), height: CGFloat(toolbarProps?.micImageHeight ?? configurationToolbarProps.micImageHeight ?? 40))
                            }
                            else{
                                KFImage(URL(string: toolbarProps?.micInactiveImage ?? configurationToolbarProps.micInactiveImage ?? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/3f10b6d7-eb71-4427-adbc-aadacbe8940e/mic-image-1-.png"))
                                    .resizable()
                                    .renderingMode((!(toolbarProps?.micInactiveColor ?? configurationToolbarProps.micInactiveColor ?? "").isEmpty) ? .template : .none)
                                    .foregroundColor(Color.init(hex: toolbarProps?.micInactiveColor ?? configurationToolbarProps.micInactiveColor ?? ""))
                                    .frame(width: CGFloat(toolbarProps?.micImageWidth ?? configurationToolbarProps.micImageWidth ?? 40), height: CGFloat(toolbarProps?.micImageHeight ?? configurationToolbarProps.micImageHeight ?? 40))
                            }
                            
                        }
                        .padding(.all, CGFloat(toolbarProps?.micImagePadding ?? configurationToolbarProps.micImagePadding ?? 4))
                        .overlay(RoundedRectangle(cornerRadius: CGFloat(toolbarProps?.micBorderRadius ?? configurationToolbarProps.micBorderRadius ?? 40)).stroke(Color.init(hex: toolbarProps?.micImageBorderColor ?? configurationToolbarProps.micImageBorderColor ?? "#8F97A1")!, lineWidth: CGFloat(toolbarProps?.micImageBorderWidth ?? configurationToolbarProps.micImageBorderWidth ?? 0)))
                        .background(Color.init(hex: isListening && isUsingSpeech ? toolbarProps?.micActiveHighlightColor ?? configurationToolbarProps.micActiveHighlightColor ?? "#1e7eb91f" : toolbarProps?.micInactiveHighlightColor ?? configurationToolbarProps.micInactiveHighlightColor ?? "00000000"))
                        .cornerRadius(CGFloat(toolbarProps?.micBorderRadius ?? configurationToolbarProps.micBorderRadius ?? 40))
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
                    TextField(toolbarProps?.placeholder ?? configurationToolbarProps.placeholder ?? "Enter a message...", text: $inputText){focused in
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
                    .font(.custom(toolbarProps?.textboxFontFamily ?? configurationToolbarProps.textboxFontFamily ?? "SF Pro" , size: CGFloat(toolbarProps?.textboxFontSize ?? configurationToolbarProps.textboxFontSize ?? 16)))
                    .padding(.leading, 10)
                    .overlay(VStack{Divider().background(Color(hex: isUsingSpeech ? toolbarProps?.textInputLineColor ?? configurationToolbarProps.textInputTextColor ?? "#CCCCCC" : toolbarProps?.textInputActiveLineColor ?? configurationToolbarProps.textInputLineColor ?? "#CCCCCC")).offset(x: 0, y: 15)}.padding(.leading, 10))
                    .accentColor(Color.init(hex: toolbarProps?.textInputCursorColor ?? configurationToolbarProps.textInputCursorColor ?? "#A3A3A3"))
                    .foregroundColor(Color.init(hex: toolbarProps?.textInputTextColor ?? configurationToolbarProps.textInputTextColor ?? "#000000"))
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
                        if isUsingSpeech {
                            KFImage(URL(string: toolbarProps?.sendInactiveImage ?? configurationToolbarProps.sendInactiveImage ?? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/0c5aa61c-7d6c-4272-abd2-75d9f5771214/Send-2-.png"))
                            .resizable()
                            .renderingMode((!(toolbarProps?.sendInactiveColor ?? configurationToolbarProps.sendInactiveColor ?? "").isEmpty) ? .template :  .none)
                            .foregroundColor(Color.init(hex: toolbarProps?.sendInactiveColor ?? configurationToolbarProps.sendInactiveColor ?? ""))
                            .frame(width: CGFloat(toolbarProps?.sendImageWidth ?? configurationToolbarProps.sendImageWidth ?? 28), height: CGFloat(toolbarProps?.sendImageHeight ?? configurationToolbarProps.sendImageHeight ?? 28))
                        }
                        else{
                            KFImage(URL(string: toolbarProps?.sendActiveImage ?? configurationToolbarProps.sendActiveImage ?? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/7a39bc6f-eef5-4185-bcf8-2a645aff53b2/Send-3-.png"))
                            .resizable()
                            .renderingMode((!isUsingSpeech && !(toolbarProps?.sendActiveColor ?? configurationToolbarProps.sendActiveColor ?? "").isEmpty) ? .template : .none)
                            .foregroundColor(Color.init(hex: toolbarProps?.sendActiveColor ?? configurationToolbarProps.sendActiveColor ?? ""))
                            .frame(width: CGFloat(toolbarProps?.sendImageWidth ?? configurationToolbarProps.sendImageWidth ?? 28), height: CGFloat(toolbarProps?.sendImageHeight ?? configurationToolbarProps.sendImageHeight ?? 28))
                        }
                        
                    }
                    .accessibilityIdentifier("sendButton")
                }
                .padding(.top, 22)
                .padding(.bottom, 10)
                .padding(.trailing, 10)
                .background(Color.init(hex: !isUsingSpeech ? toolbarProps?.textboxActiveHighlightColor ?? configurationToolbarProps.textboxActiveHighlightColor ?? "#1e7eb91f" : toolbarProps?.textboxInactiveHighlightColor ?? configurationToolbarProps.textboxInactiveHighlightColor ?? "00000000"))
                .cornerRadius(CGFloat(10))
            }
                    
        }
        .padding(.leading, CGFloat(toolbarParameters.paddingLeft))
        .padding(.trailing, CGFloat(toolbarParameters.paddingRight))
        .padding(.bottom, CGFloat(toolbarParameters.paddingBottom))
        .padding(.top, CGFloat(toolbarParameters.paddingTop))
        .background(Color(hex: !(toolbarProps?.backgroundColor ?? "").isEmpty ? toolbarProps?.backgroundColor ?? "" :
                            !(configurationToolbarProps.backgroundColor ?? "").isEmpty ? configurationToolbarProps.backgroundColor ?? "" :
                             !(assistantSettingsProps.backgroundColor ?? "").isEmpty ? assistantSettingsProps.backgroundColor ?? ""
                          :!(configurationSettingsProps.backgroundColor ?? "").isEmpty ? configurationSettingsProps.backgroundColor ?? "" : "#ffffff"))
        .onChange(of: isListening){ _ in
            if(isListening == false)
            {
                voicifySTT.stopListening()
            }
        }
        .onAppear{
            //have to map prop logic outside of view modifiers to avoid compile error "unable to type check in time"
            toolbarParameters =
            ToolbarParameters(
                assistantStatefont: toolbarProps?.assistantStateFontFamily ?? configurationToolbarProps.assistantStateFontFamily ?? "SF Pro",
                assistantStateFontSize: toolbarProps?.assistantStateFontSize ?? configurationToolbarProps.assistantStateFontSize ?? 16,
                assistantStateForegroundColor: toolbarProps?.assistantStateTextColor ?? configurationToolbarProps.assistantStateTextColor ?? "#8F97A1",
                              inputSpeechStatefont: toolbarProps?.partialSpeechResultFontFamily ?? configurationToolbarProps.partialSpeechResultFontFamily ?? "SF Pro",
                inputSpeechFontSize: toolbarProps?.partialSpeechResultFontSize ?? configurationToolbarProps.partialSpeechResultFontSize ?? 18, inputSpeechPartialForegroundColor: toolbarProps?.partialSpeechResultTextColor ?? configurationToolbarProps.partialSpeechResultTextColor ?? "#ffffff33",
                              inputSpeechFinalForegroundColor: toolbarProps?.fullSpeechResultTextColor ?? configurationToolbarProps.fullSpeechResultTextColor ?? "#ffffff",
                helpFont: toolbarProps?.helpTextFontFamily ?? configurationToolbarProps.helpTextFontFamily ?? "SF Pro",
                helpFontSize: toolbarProps?.helpTextFontSize ?? configurationToolbarProps.helpTextFontSize ?? 18,
                helpForegroundColor: toolbarProps?.helpTextFontColor ?? configurationToolbarProps.helpTextFontColor ?? "#8F97A1",
                speakFont: toolbarProps?.speakFontFamily ?? configurationToolbarProps.speakFontFamily ?? "SF Pro",
                speakFontSize: toolbarProps?.speakFontSize ?? configurationToolbarProps.speakFontSize ?? 14,
                speakActiveForegroundColor: toolbarProps?.speakActiveTitleColor ?? configurationToolbarProps.speakActiveTitleColor ?? "#3E77A5",
                speakInactiveForegroundColor: toolbarProps?.speakInactiveTitleColor ?? configurationToolbarProps.speakActiveTitleColor ?? "#8F97A1",
                typeFont: toolbarProps?.typeFontFamily ?? configurationToolbarProps.typeFontFamily ?? "SF Pro",
                typeFontSize: toolbarProps?.typeFontSize ?? configurationToolbarProps.typeFontSize ?? 14,
                typeActiveForegroundColor: toolbarProps?.typeActiveTitleColor ?? configurationToolbarProps.typeActiveTitleColor ?? "#3E77A5",
                typeInactiveForegroundColor: toolbarProps?.typeInactiveTitleColor  ?? configurationToolbarProps.typeInactiveTitleColor ?? "#8F97A1",
                              paddingTop: toolbarProps?.paddingTop ?? 10,
                              paddingRight: toolbarProps?.paddingRight ?? 20,
                              paddingBottom: toolbarProps?.paddingLeft ?? 20,
                              paddingLeft: toolbarProps?.paddingBottom ?? 20
            )
        }
    }
}
