//
//  AssistantDrawerUI.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 11/3/22.
//

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
    var voicifyAssistant: VoicifyAssistant
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

    public init(
        assistantSettings: AssistantSettingsProps,
        headerProps: HeaderProps?,
        bodyProps: BodyProps?,
        toolBarProps: ToolBarProps?
    ) {
        self.assistantSettingsProps = assistantSettings
        self.headerProps = headerProps
        self.bodyProps = bodyProps
        self.toolBarProps = toolBarProps
        self._assistantIsOpen = assistantSettingsProps.assistantIsOpen
        voicifySTT = VoicifySTTProvider()
        voicifyTTS = VoicifyTTSProivder(
            settings: VoicifyTextToSpeechSettings(
                appId: assistantSettings.appId,
                appKey: assistantSettings.appKey,
                voice: assistantSettings.voice,
                serverRootUrl: assistantSettings.serverRootUrl,
                provider: assistantSettings.textToSpeechProvider
            )
        )
        voicifyAssistant = VoicifyAssistant(
            speechToTextProvider: voicifySTT,
            textToSpeechProvider: voicifyTTS,
            settings: VoicifyAssistantSettings(
                serverRootUrl: assistantSettings.serverRootUrl,
                appId: assistantSettings.appId,
                appKey: assistantSettings.appKey,
                locale: assistantSettings.locale,
                channel: assistantSettings.channel,
                device: assistantSettings.device,
                autoRunConversation: assistantSettings.autoRunConversation,
                initializeWithWelcomeMessage: assistantSettings.initializeWithWelcomeMessage,
                initializeWithText: assistantSettings.initializeWithText,
                useVoiceInput: assistantSettings.useVoiceInput,
                useDraftContent: assistantSettings.useDraftContent,
                useOutputSpeech: assistantSettings.useOutputSpeech,
                noTracking: assistantSettings.noTracking
            )
        )
        voicifyAssistant.initializeAndStart()
    }
    
    public var body: some View {
        BottomSheet(
            isPresented: $assistantIsOpen,
            height: assistantSettingsProps.initializeWithWelcomeMessage && !isFullScreen ? 0 : isFullScreen ? UIScreen.main.bounds.height : !isUsingSpeech ? CGFloat(toolBarProps?.drawerTextHeight ?? 220) : CGFloat(toolBarProps?.drawerSpeechHeight ?? 330),
            topBarHeight: 0 ,
            showTopIndicator: false)
        {
            VStack(spacing: 0){
                if isFullScreen {
                    AssistantDrawerUIHeader(
                        assistantIsOpen: $assistantIsOpen,
                        headerProps: headerProps
                    )
                    AssistantDrawerUIBody(
                        messages: $messages,
                        isUsingSpeech: $isUsingSpeech,
                        keyboardToggled: $keyboardToggled,
                        hints: $hints,
                        inputText: $inputText,
                        inputSpeech: $inputSpeech,
                        voicifySTT: voicifySTT,
                        voicifyTTS: voicifyTTS,
                        voicifyAssistant: voicifyAssistant,
                        bodyProps: bodyProps
                    )
                }
                AssistantDrawerUIToolbar(
                    assistantIsOpen: $assistantIsOpen,
                    isFullScreen: $isFullScreen,
                    isUsingSpeech: $isUsingSpeech,
                    isSpeaking: $isSpeaking,
                    animationValues: $animationValues,
                    assistatStateText: $assistantStateText,
                    inputSpeech: $inputSpeech,
                    inputText: $inputText,
                    isFinalSpeech: $isFinalSpeech,
                    isListening: $isListening,
                    showPermissionAlert: $showPermissionAlert,
                    keyboardToggled:$keyboardToggled,
                    messages: $messages,
                    hints: $hints,
                    voicifySTT: voicifySTT,
                    voicifyTTS: voicifyTTS,
                    voicifyAssistant: voicifyAssistant,
                    headerProps: headerProps,
                    toolBarProps: toolBarProps
                )
            }
        }
        .onChange(of: assistantIsOpen){ _ in
            if(assistantIsOpen == true){
                voicifyTTS.cancelSpeech = false
                voicifySTT.cancel = false
                voicifyAssistant.ClearHandlers()
                voicifySTT.clearHandlers()
                inputSpeech = ""
                inputText = ""
                responseText = ""
                voicifySTT.addPartialListener{(partialResult:String) -> Void in
                    inputSpeech = partialResult
                }
                voicifySTT.addFinalResultListener{(fullResult: String) -> Void  in
                    isFinalSpeech = true
                    assistantStateText = " "
                    inputSpeech = fullResult
                    voicifyAssistant.makeTextRequest(text: inputSpeech, inputType: "Speech")
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
                voicifyAssistant.onResponseReceived{response in
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
                    voicifyAssistant.onEffect(effectName: effect){data in
                        assistantSettingsProps.onEffect(effect, data)
                    }
                }

                voicifyAssistant.startNewSession(sessionId: nil, userId: nil, sessionAttributes: assistantSettingsProps.sessionAttributes, userAttributes: assistantSettingsProps.userAttributes)
            }
            else{
                UIApplication.shared.endEditing()
                inputSpeech = ""
                messages = []
                voicifyTTS.cancelSpeech = true
                voicifySTT.cancel = true
                isFullScreen = false
                if(isListening)
                {
                    voicifySTT.stopListening()
                }
                voicifyTTS.stop()
                voicifyTTS.clearHandlers()
                voicifySTT.clearHandlers()
                voicifyAssistant.ClearHandlers()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .padding(.bottom, assistantIsOpen ? 0.1 : 0) // if keyboard is active - causes view to lift
    }
}
