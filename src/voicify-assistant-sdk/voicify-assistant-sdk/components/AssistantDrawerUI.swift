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
    var toolbarProps: ToolbarProps? = nil
    @State var voicifySTT: VoicifySTTProvider? = nil
    @State var voicifyTTS: VoicifyTTSProivder? = nil
    @State var voicifyAssistant: VoicifyAssistant? = nil
    @State var assistantBackgroundGradientColors: Array<Color> = []
    @State var equalizerGradientColors: Array<Color> = []
    var openAssistantNotifcation = NotificationCenter.default.publisher(for: NSNotification.Name.openAssistant)
    var closeAssistantNotification = NotificationCenter.default.publisher(for: NSNotification.Name.closeAssistant)
    @State var assistantIsOpen = false
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
    @State var isKeyboardActive = false
    @State var showNoInternetCloseButton = false
    @StateObject var configurationSettingsProps = ConfigurationSettingsProps(serverRootUrl: "", appId: "", appKey: "")
    @StateObject var configurationHeaderProps = ConfigurationHeaderProps()
    @StateObject var configurationBodyProps = ConfigurationBodyProps()
    @StateObject var configurationToolbarProps = ConfigurationToolbarProps()
    @ObservedObject var keyboardHeightHelper = KeyboardHeightHelper()

    public init(
        assistantSettings: AssistantSettingsProps,
        headerProps: HeaderProps? = nil,
        bodyProps: BodyProps? = nil,
        toolbarProps: ToolbarProps? = nil
    ) {
        self.assistantSettingsProps = assistantSettings
        self.headerProps = headerProps
        self.bodyProps = bodyProps
        self.toolbarProps = toolbarProps
    }
    
    public var body: some View {
        BottomSheet(
            isPresented: $assistantIsOpen,
            height: isFullScreen ? UIScreen.main.bounds.height : !isUsingSpeech ? CGFloat(toolbarProps?.drawerTextHeight ?? 220) : CGFloat(toolbarProps?.drawerSpeechHeight ?? 330),
            topBarHeight: 0 ,
            showTopIndicator: false)
        {
            VStack(spacing: 0){
                if let tts = voicifyTTS,
                   let stt = voicifySTT,
                   let assistant = voicifyAssistant{
                    if isFullScreen {
                        AssistantDrawerUIHeader(
                            assistantIsOpen: $assistantIsOpen,
                            showNoInternetCloseButton: $showNoInternetCloseButton,
                            headerProps: headerProps,
                            assistantSettings: assistantSettingsProps
                        )
                        AssistantDrawerUIBody(
                            messages: $messages,
                            isUsingSpeech: $isUsingSpeech,
                            keyboardToggled: $keyboardToggled,
                            hints: $hints,
                            inputText: $inputText,
                            inputSpeech: $inputSpeech,
                            voicifySTT: stt,
                            voicifyTTS: tts,
                            voicifyAssistant: assistant,
                            bodyProps: bodyProps,
                            assistantSettings: assistantSettingsProps
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
                        equalizerGradientColors: $equalizerGradientColors,
                        voicifySTT: stt,
                        voicifyTTS: tts,
                        voicifyAssistant: assistant,
                        headerProps: headerProps,
                        toolbarProps: toolbarProps,
                        assistantSettingsProps: assistantSettingsProps
                    )
                    .padding(.bottom, isFullScreen ? self.keyboardHeightHelper.keyboardHeight : 0)
                }
                
            }
            .background(
                !assistantBackgroundGradientColors.isEmpty ?
                 LinearGradient(gradient: Gradient(colors: assistantBackgroundGradientColors), startPoint: .top, endPoint: .bottom)
                :
                    LinearGradient(gradient: Gradient(colors: [Color.init(hex: "#00000000")!]), startPoint: .top, endPoint: .bottom)
            )
        }
        .onAppear{
            let customAssistantConfigurationService = CustomAssistantConfigurationService()
            Task{
                do{
                    let configuration = try await customAssistantConfigurationService.getCustomAssistantConfiguration(configurationId:assistantSettingsProps.configurationId, serverRootUrl: assistantSettingsProps.serverRootUrl, appId: assistantSettingsProps.appId, appKey: assistantSettingsProps.appKey)
                    
                    customAssistantConfigurationService.mapSettingsProps(configuration: configuration,configurationSettingsProps: configurationSettingsProps, assistantSettingsProps: assistantSettingsProps)
                    customAssistantConfigurationService.mapHeaderProps(configuration: configuration, configurationHeaderProps: configurationHeaderProps)
                    customAssistantConfigurationService.mapBodyProps(configuration: configuration, configurationBodyProps: configurationBodyProps)
                    customAssistantConfigurationService.mapToolbarProps(configuration: configuration, configurationToolbarProps: configurationToolbarProps)
                    
                    voicifySTT = VoicifySTTProvider()
                    voicifyTTS = VoicifyTTSProivder(
                        settings: VoicifyTextToSpeechSettings(
                            appId: assistantSettingsProps.appId,
                            appKey: assistantSettingsProps.appKey,
                            voice: assistantSettingsProps.textToSpeechVoice ?? configuration.textToSpeechVoice ?? "",
                            serverRootUrl: assistantSettingsProps.serverRootUrl,
                            provider: assistantSettingsProps.textToSpeechProvider ?? configuration.textToSpeechProvider ?? "Google"
                        )
                    )
                    voicifyAssistant = VoicifyAssistant(
                        speechToTextProvider: voicifySTT,
                        textToSpeechProvider: voicifyTTS,
                        settings: VoicifyAssistantSettings(
                            serverRootUrl: assistantSettingsProps.serverRootUrl,
                            appId: assistantSettingsProps.appId,
                            appKey: assistantSettingsProps.appKey,
                            locale: assistantSettingsProps.locale ?? configuration.locale ?? "en-US",
                            channel: assistantSettingsProps.channel ?? configuration.channel ?? "iOS",
                            device: assistantSettingsProps.device ?? configuration.device ?? "Mobile",
                            autoRunConversation: assistantSettingsProps.autoRunConversation ?? configuration.autoRunConversation ?? false,
                            initializeWithWelcomeMessage: assistantSettingsProps.initializeWithWelcomeMessage ?? configuration.initializeWithWelcomeMessage ?? false,
                            initializeWithText: assistantSettingsProps.initializeWithText ?? (configuration.activeInput == "textbox"),
                            useVoiceInput: assistantSettingsProps.useVoiceInput ?? configuration.useVoiceInput ?? true,
                            useDraftContent: assistantSettingsProps.useDraftContent ?? configuration.useDraftContent ?? false,
                            useOutputSpeech: assistantSettingsProps.useOutputSpeech ?? configuration.useOutputSpeech ?? true,
                            noTracking: assistantSettingsProps.noTracking ?? configuration.noTracking ?? false
                        )
                    )
                    voicifyAssistant?.initializeAndStart()
                }
                catch {
                    voicifySTT = VoicifySTTProvider()
                    voicifyTTS = VoicifyTTSProivder(
                        settings: VoicifyTextToSpeechSettings(
                            appId: assistantSettingsProps.appId,
                            appKey: assistantSettingsProps.appKey,
                            voice: assistantSettingsProps.textToSpeechVoice ?? "",
                            serverRootUrl: assistantSettingsProps.serverRootUrl,
                            provider: assistantSettingsProps.textToSpeechProvider ?? "Google"
                        )
                    )
                    voicifyAssistant = VoicifyAssistant(
                        speechToTextProvider: voicifySTT,
                        textToSpeechProvider: voicifyTTS,
                        settings: VoicifyAssistantSettings(
                            serverRootUrl: assistantSettingsProps.serverRootUrl,
                            appId: assistantSettingsProps.appId,
                            appKey: assistantSettingsProps.appKey,
                            locale: assistantSettingsProps.locale ?? "en-US",
                            channel: assistantSettingsProps.channel ?? "iOS",
                            device: assistantSettingsProps.device ?? "Mobile",
                            autoRunConversation: assistantSettingsProps.autoRunConversation ?? false,
                            initializeWithWelcomeMessage: assistantSettingsProps.initializeWithWelcomeMessage ?? false,
                            initializeWithText: assistantSettingsProps.initializeWithText ?? false,
                            useVoiceInput: assistantSettingsProps.useVoiceInput ?? true,
                            useDraftContent: assistantSettingsProps.useDraftContent ?? false,
                            useOutputSpeech: assistantSettingsProps.useOutputSpeech ?? true,
                            noTracking: assistantSettingsProps.noTracking ?? false
                        )
                    )
                    voicifyAssistant?.initializeAndStart()
                }
                
            }
        }
        .environmentObject(configurationSettingsProps)
        .environmentObject(configurationHeaderProps)
        .environmentObject(configurationBodyProps)
        .environmentObject(configurationToolbarProps)
        .onChange(of: assistantIsOpen){ _ in
            if let tts = voicifyTTS,
               let stt = voicifySTT,
               let assistant = voicifyAssistant{
                if(assistantIsOpen == true){
                    if(assistantBackgroundGradientColors.isEmpty)
                    {
                        if let backgroundGradientColors = assistantSettingsProps.backgroundColor{
                            let splitColors = backgroundGradientColors.components(separatedBy: ",")
                            if (splitColors.count > 1)
                            {
                                splitColors.forEach{ color in
                                    self.assistantBackgroundGradientColors.append(Color.init(hex: color)!)
                                }
                            }
                        }
                        else if let configurationBackgroundGradientColors = configurationSettingsProps.backgroundColor {
                            let splitColors = configurationBackgroundGradientColors.components(separatedBy: ",")
                            if (splitColors.count > 1)
                            {
                                splitColors.forEach{ color in
                                    self.assistantBackgroundGradientColors.append(Color.init(hex: color)!)
                                }
                            }
                        }
                    }
                    
                    if (equalizerGradientColors.isEmpty)
                    {
                        if let equalizerGradColors = toolbarProps?.equalizerColor{
                            let splitColors = equalizerGradColors.components(separatedBy: ",")
                            if (splitColors.count > 1)
                            {
                                splitColors.forEach{ color in
                                    self.equalizerGradientColors.append(Color.init(hex: color)!)
                                }
                            }
                        }
                        else if let configurationEqualizerGradColors = configurationToolbarProps.equalizerColor {
                            let splitColors = configurationEqualizerGradColors.components(separatedBy: ",")
                            if (splitColors.count > 1)
                            {
                                splitColors.forEach{ color in
                                    self.equalizerGradientColors.append(Color.init(hex: color)!)
                                }
                            }
                        }
                    }
                    
                    tts.cancelSpeech = false
                    stt.cancel = false
                    assistant.ClearHandlers()
                    stt.clearHandlers()
                    //add out of the box effect
                    assistant.onEffect(effectName: "closeAssistant", callback: closeAssistantCallback)
                    if let onErrorCallback = assistantSettingsProps.onAssistantError{
                        assistant.onError{error,request in
                            if (request.context.requestName == "VoicifyWelcome")
                            {
                                showNoInternetCloseButton = true
                            }
                            onErrorCallback(error, request)
                        }
                    }
                    inputSpeech = ""
                    inputText = ""
                    responseText = ""
                    stt.addPartialListener{(partialResult:String) -> Void in
                        inputSpeech = partialResult
                    }
                    stt.addFinalResultListener{(fullResult: String) -> Void  in
                        isFinalSpeech = true
                        assistantStateText = " "
                        inputSpeech = fullResult
                        assistant.makeTextRequest(text: inputSpeech, inputType: "Speech")
                    }
                    stt.addVolumeListener{(volume: Float) -> Void in
                        for i in 0...7 {
                            let value = CGFloat.random(in: 0...CGFloat(volume))
                            animationValues[i] = value
                        }
                        if isSpeaking == false{
                            isSpeaking = true
                        }
                    }
                    stt.addStartListener {
                        isListening = true
                        isFinalSpeech = false
                        assistantStateText = "Listening..."
                    }
                    stt.addEndListener {
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
                    assistant.onResponseReceived{response in
                        showNoInternetCloseButton = false
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
                    if(assistantSettingsProps.initializeWithWelcomeMessage ?? configurationSettingsProps.initializeWithWelcomeMessage ?? true)
                    {
                        isFullScreen = true
                        if(!(assistantSettingsProps.initializeWithText ?? configurationSettingsProps.initializeWithText ?? false) && (assistantSettingsProps.useVoiceInput ?? configurationSettingsProps.useVoiceInput ?? true))
                        {
                            isUsingSpeech = true
                        }
                        else{
                            isUsingSpeech = false
                        }
                    }
                    else if (!(assistantSettingsProps.initializeWithText ?? configurationSettingsProps.initializeWithText ?? false) && (assistantSettingsProps.useVoiceInput ?? configurationSettingsProps.useVoiceInput ?? true)){
                        if(stt.hasPermission)
                        {
                            stt.startListening()
                            isUsingSpeech = true
                        }
                    }
                    else{
                        isUsingSpeech = false
                    }
                    if let assistantEffect = assistantSettingsProps.effects {
                        assistantEffect.forEach{effect in
                            assistant.onEffect(effectName: effect){data in
                                if let onEffectCallback = assistantSettingsProps.onEffect {
                                    onEffectCallback(effect, data)
                                }
                            }
                        }
                    }
                    
                    assistant.startNewSession(sessionId: nil, userId: nil, sessionAttributes: assistantSettingsProps.sessionAttributes, userAttributes: assistantSettingsProps.userAttributes)
                }
                else{
                    UIApplication.shared.endEditing()
                    inputSpeech = ""
                    messages = []
                    tts.cancelSpeech = true
                    stt.cancel = true
                    isFullScreen = false
                    if(isListening)
                    {
                        stt.stopListening()
                    }
                    tts.stop()
                    tts.clearHandlers()
                    stt.clearHandlers()
                    assistant.ClearHandlers()
                    if let onCloseCallback = assistantSettingsProps.onAssistantClose{
                        onCloseCallback()
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .padding(.bottom, assistantIsOpen && !isFullScreen ? 0.1 : 0) // if keyboard is active - causes view to lift
        .onReceive(openAssistantNotifcation){data in
            self.assistantIsOpen = true
        }
        .onReceive(closeAssistantNotification){data in
            self.assistantIsOpen = false
        }
    }
}
