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
                    mapHeaderProps(configuration: configuration)
                    mapBodyProps(configuration: configuration)
                    mapToolbarProps(configuration: configuration)
                    voicifySTT = VoicifySTTProvider()
                    voicifyTTS = VoicifyTTSProivder(
                        settings: VoicifyTextToSpeechSettings(
                            appId: configuration.applicationId!,
                            appKey: configuration.applicationSecret!,
                            voice: configuration.textToSpeechVoice ?? "",
                            serverRootUrl: self.assistantSettingsProps.serverRootUrl,
                            provider: configuration.textToSpeechProvider ?? "Google"
                        )
                    )
                    voicifyAssistant = VoicifyAssistant(
                        speechToTextProvider: voicifySTT,
                        textToSpeechProvider: voicifyTTS,
                        settings: VoicifyAssistantSettings(
                            serverRootUrl: assistantSettingsProps.serverRootUrl,
                            appId: configuration.applicationId!,
                            appKey: configuration.applicationSecret!,
                            locale: configuration.locale ?? "en-US",
                            channel: configuration.channel ?? "iOS",
                            device: configuration.device ?? "Mobile",
                            autoRunConversation: configuration.autoRunConversation ?? false,
                            initializeWithWelcomeMessage: configuration.initializeWithWelcomeMessage ?? false,
                            initializeWithText: configuration.activeInput == "textbox" ? true : false,
                            useVoiceInput: configuration.useVoiceInput ?? true,
                            useDraftContent: configuration.useDraftContent ?? false,
                            useOutputSpeech: configuration.useOutputSpeech ?? true,
                            noTracking: configuration.noTracking ?? false
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
                    }
                    
                    tts.cancelSpeech = false
                    stt.cancel = false
                    assistant.ClearHandlers()
                    stt.clearHandlers()
                    //add out of the box effect
                    assistant.onEffect(effectName: "closeAssistant", callback: closeAssistantCallback)
                    if let onErrorCallback = assistantSettingsProps.onAssistantError{
                        assistant.onError(callback: onErrorCallback)
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
                    if let initializeWithWlecome = assistantSettingsProps.initializeWithWelcomeMessage
                    {
                        if(initializeWithWlecome == true)
                        {
                            isFullScreen = true
                            if(assistantSettingsProps.initializeWithText == false && assistantSettingsProps.useVoiceInput == true)
                            {
                                isUsingSpeech = true
                            }
                            else{
                                isUsingSpeech = false
                            }
                        }
                    }
                    else if (assistantSettingsProps.initializeWithText == false && assistantSettingsProps.useVoiceInput == true){
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
    
    func mapHeaderProps(configuration: CustomAssistantConfigurationResponse){
        if let backgroundColor = configuration.styles?.header.backgroundColor{
            configurationHeaderProps.backgroundColor = backgroundColor
        }
        if let assistantName = configuration.styles?.header.assistantName{
            configurationHeaderProps.assistantName = assistantName
        }
        if let assistantImage = configuration.styles?.header.assistantImage{
            configurationHeaderProps.assistantImage = assistantImage
        }
        if let assistantImageBackgroundColor = configuration.styles?.header.assistantImageBackgroundColor{
            configurationHeaderProps.assistantImageBackgroundColor = assistantImageBackgroundColor
        }
        if let assistantImageBorderRadius = configuration.styles?.header.assistantImageBorderRadius{
            configurationHeaderProps.assistantImageBorderRadius = assistantImageBorderRadius
        }
        if let assistantImageBorderColor = configuration.styles?.header.assistantImageBorderColor{
            configurationHeaderProps.assistantImageBorderColor = assistantImageBorderColor
        }
        if let assistantImageBorderWidth = configuration.styles?.header.assistantImageBorderWidth{
            configurationHeaderProps.assistantImageBorderWidth = assistantImageBorderWidth
        }
        if let assistantImageColor = configuration.styles?.header.assistantImageColor{
            configurationHeaderProps.assistantImageColor = assistantImageColor
        }
        if let assistantImageHeight = configuration.styles?.header.assistantImageHeight{
            configurationHeaderProps.assistantImageHeight = assistantImageHeight
        }
        if let assistantImageWidth = configuration.styles?.header.assistantImageWidth{
            configurationHeaderProps.assistantImageWidth = assistantImageWidth
        }
        if let closeAssistantButtonBackgroundColor = configuration.styles?.header.closeAssistantButtonBackgroundColor{
            configurationHeaderProps.closeAssistantButtonBackgroundColor = closeAssistantButtonBackgroundColor
        }
        if let closeAssistantButtonBorderColor = configuration.styles?.header.closeAssistantButtonBorderColor{
            configurationHeaderProps.closeAssistantButtonBorderColor = closeAssistantButtonBorderColor
        }
        if let closeAssistantButtonBorderRadius = configuration.styles?.header.closeAssistantButtonBorderRadius{
            configurationHeaderProps.closeAssistantButtonBorderRadius = closeAssistantButtonBorderRadius
        }
        if let closeAssistantButtonBorderWidth = configuration.styles?.header.closeAssistantButtonBorderWidth{
            configurationHeaderProps.closeAssistantButtonBorderWidth = closeAssistantButtonBorderWidth
        }
        if let closeAssistantButtonImage = configuration.styles?.header.closeAssistantButtonImage{
            configurationHeaderProps.closeAssistantButtonImage = closeAssistantButtonImage
        }
        if let closeAssistantButtonImageHeight = configuration.styles?.header.closeAssistantButtonImageHeight{
            configurationHeaderProps.closeAssistantButtonImageHeight = closeAssistantButtonImageHeight
        }
        if let closeAssistantButtonImageWidth = configuration.styles?.header.closeAssistantButtonImageWidth{
            configurationHeaderProps.closeAssistantButtonImageWidth = closeAssistantButtonImageWidth
        }
        if let closeAssistantColor = configuration.styles?.header.closeAssistantColor{
            configurationHeaderProps.closeAssistantColor = closeAssistantColor
        }
        if let fontFamily = configuration.styles?.header.fontFamily{
            configurationHeaderProps.fontFamily = fontFamily
        }
        if let fontSize = configuration.styles?.header.fontSize{
            configurationHeaderProps.fontSize = fontSize
        }
        if let paddingBottom = configuration.styles?.header.paddingBottom{
            configurationHeaderProps.paddingBottom = paddingBottom
        }
        if let paddingLeft = configuration.styles?.header.paddingLeft{
            configurationHeaderProps.paddingLeft = paddingLeft
        }
        if let paddingRight = configuration.styles?.header.paddingRight{
            configurationHeaderProps.paddingRight = paddingRight
        }
        if let paddingTop = configuration.styles?.header.paddingTop{
            configurationHeaderProps.paddingTop = paddingTop
        }
    }
    
    func mapBodyProps(configuration: CustomAssistantConfigurationResponse){
        if let backgroundColor = configuration.styles?.body.backgroundColor{
            configurationBodyProps.backgroundColor = backgroundColor
        }
        if let assistantImage = configuration.styles?.body.assistantImage{
            configurationBodyProps.assistantImage = assistantImage
        }
        if let paddingTop = configuration.styles?.body.paddingTop{
            configurationBodyProps.paddingTop = paddingTop
        }
        if let paddingRight = configuration.styles?.body.paddingRight{
            configurationBodyProps.paddingRight = paddingRight
        }
        if let paddingLeft = configuration.styles?.body.paddingLeft{
            configurationBodyProps.paddingLeft = paddingLeft
        }
        if let paddingBottom = configuration.styles?.body.paddingBottom{
            configurationBodyProps.paddingBottom = paddingBottom
        }
        if let assistantImageWidth = configuration.styles?.body.assistantImageWidth{
            configurationBodyProps.assistantImageWidth = assistantImageWidth
        }
        if let assistantImageHeight = configuration.styles?.body.assistantImageHeight{
            configurationBodyProps.assistantImageHeight = assistantImageHeight
        }
        if let assistantImageColor = configuration.styles?.body.assistantImageColor{
            configurationBodyProps.assistantImageColor = assistantImageColor
        }
        if let assistantImageBorderWidth = configuration.styles?.body.assistantImageBorderWidth{
            configurationBodyProps.assistantImageBorderWidth = assistantImageBorderWidth
        }
        if let assistantImageBorderColor = configuration.styles?.body.assistantImageBorderColor{
            configurationBodyProps.assistantImageBorderColor = assistantImageBorderColor
        }
        if let assistantImageBorderRadius = configuration.styles?.body.assistantImageBorderRadius{
            configurationBodyProps.assistantImageBorderRadius = assistantImageBorderRadius
        }
        if let assistantImageBackgroundColor = configuration.styles?.body.assistantImageBackgroundColor{
            configurationBodyProps.assistantImageBackgroundColor = assistantImageBackgroundColor
        }
        if let borderBottomColor = configuration.styles?.body.borderBottomColor{
            configurationBodyProps.borderBottomColor = borderBottomColor
        }
        if let borderBottomWidth = configuration.styles?.body.borderBottomWidth{
            configurationBodyProps.borderBottomWidth = borderBottomWidth
        }
        if let borderTopColor = configuration.styles?.body.borderTopColor{
            configurationBodyProps.borderTopColor = borderTopColor
        }
        if let borderTopWidth = configuration.styles?.body.borderTopWidth{
            configurationBodyProps.borderTopWidth = borderTopWidth
        }
        if let hintsBackgroundColor = configuration.styles?.body.hintsBackgroundColor{
            configurationBodyProps.hintsBackgroundColor = hintsBackgroundColor
        }
        if let hintsBorderColor = configuration.styles?.body.hintsBorderColor{
            configurationBodyProps.hintsBorderColor = hintsBorderColor
        }
        if let hintsBorderRadius = configuration.styles?.body.hintsBorderRadius{
            configurationBodyProps.hintsBorderRadius = hintsBorderRadius
        }
        if let hintsBorderWidth = configuration.styles?.body.hintsBorderWidth{
            configurationBodyProps.hintsBorderWidth = hintsBorderWidth
        }
        if let hintsFontFamily = configuration.styles?.body.hintsFontFamily{
            configurationBodyProps.hintsFontFamily = hintsFontFamily
        }
        if let hintsFontSize = configuration.styles?.body.hintsFontSize{
            configurationBodyProps.hintsFontSize = hintsFontSize
        }
        if let hintsPaddingBottom = configuration.styles?.body.hintsPaddingBottom{
            configurationBodyProps.hintsPaddingBottom = hintsPaddingBottom
        }
        if let hintsPaddingLeft = configuration.styles?.body.hintsPaddingLeft{
            configurationBodyProps.hintsPaddingLeft = hintsPaddingLeft
        }
        if let hintsPaddingRight = configuration.styles?.body.hintsPaddingRight{
            configurationBodyProps.hintsPaddingRight = hintsPaddingRight
        }
        if let hintsPaddingTop = configuration.styles?.body.hintsPaddingTop{
            configurationBodyProps.hintsPaddingTop = hintsPaddingTop
        }
        if let hintsTextColor = configuration.styles?.body.hintsTextColor{
            configurationBodyProps.hintsTextColor = hintsTextColor
        }
        if let messageReceivedBackgroundColor = configuration.styles?.body.messageReceivedBackgroundColor{
            configurationBodyProps.messageReceivedBackgroundColor = messageReceivedBackgroundColor
        }
        if let messageReceivedBorderBottomLeftRadius = configuration.styles?.body.messageReceivedBorderBottomLeftRadius{
            configurationBodyProps.messageReceivedBorderBottomLeftRadius = messageReceivedBorderBottomLeftRadius
        }
        if let messageReceivedBorderBottomRightRadius = configuration.styles?.body.messageReceivedBorderBottomRightRadius{
            configurationBodyProps.messageReceivedBorderBottomRightRadius = messageReceivedBorderBottomRightRadius
        }
        if let messageReceivedBorderColor = configuration.styles?.body.messageReceivedBorderColor{
            configurationBodyProps.messageReceivedBorderColor = messageReceivedBorderColor
        }
        if let messageReceivedBorderTopLeftRadius = configuration.styles?.body.messageReceivedBorderTopLeftRadius{
            configurationBodyProps.messageReceivedBorderTopLeftRadius = messageReceivedBorderTopLeftRadius
        }
        if let messageReceivedBorderTopRightRadius = configuration.styles?.body.messageReceivedBorderTopRightRadius{
            configurationBodyProps.messageReceivedBorderTopRightRadius = messageReceivedBorderTopRightRadius
        }
        if let messageReceivedBorderWidth = configuration.styles?.body.messageReceivedBorderWidth{
            configurationBodyProps.messageReceivedBorderWidth = messageReceivedBorderWidth
        }
        if let messageReceivedFontFamily = configuration.styles?.body.messageReceivedFontFamily{
            configurationBodyProps.messageReceivedFontFamily = messageReceivedFontFamily
        }
        if let messageReceivedFontSize = configuration.styles?.body.messageReceivedFontSize{
            configurationBodyProps.messageReceivedFontSize = messageReceivedFontSize
        }
        if let messageReceivedTextColor = configuration.styles?.body.messageReceivedTextColor{
            configurationBodyProps.messageReceivedTextColor = messageReceivedTextColor
        }
        if let messageSentBackgroundColor = configuration.styles?.body.messageSentBackgroundColor{
            configurationBodyProps.messageSentBackgroundColor = messageSentBackgroundColor
        }
        if let messageSentBorderBottomLeftRadius = configuration.styles?.body.messageSentBorderBottomLeftRadius{
            configurationBodyProps.messageSentBorderBottomLeftRadius = messageSentBorderBottomLeftRadius
        }
        if let messageSentBorderBottomRightRadius = configuration.styles?.body.messageSentBorderBottomRightRadius{
            configurationBodyProps.messageSentBorderBottomRightRadius = messageSentBorderBottomRightRadius
        }
        if let messageSentBorderColor = configuration.styles?.body.messageSentBorderColor{
            configurationBodyProps.messageSentBorderColor = messageSentBorderColor
        }
        if let messageSentBorderTopLeftRadius = configuration.styles?.body.messageSentBorderTopLeftRadius{
            configurationBodyProps.messageSentBorderTopLeftRadius = messageSentBorderTopLeftRadius
        }
        if let messageSentBorderTopRightRadius = configuration.styles?.body.messageSentBorderTopRightRadius{
            configurationBodyProps.messageSentBorderTopRightRadius = messageSentBorderTopRightRadius
        }
        if let messageSentBorderWidth = configuration.styles?.body.messageSentBorderWidth{
            configurationBodyProps.messageSentBorderWidth = messageSentBorderWidth
        }
        if let messageSentFontFamily = configuration.styles?.body.messageSentFontFamily{
            configurationBodyProps.messageSentFontFamily = messageSentFontFamily
        }
        if let messageSentFontSize = configuration.styles?.body.messageSentFontSize{
            configurationBodyProps.messageSentFontSize = messageSentFontSize
        }
        if let messageSentTextColor = configuration.styles?.body.messageSentTextColor{
            configurationBodyProps.messageSentTextColor = messageSentTextColor
        }
    }
    
    func mapToolbarProps(configuration: CustomAssistantConfigurationResponse){
        if let backgroundColor = configuration.styles?.toolbar.backgroundColor{
            configurationToolbarProps.backgroundColor = backgroundColor
        }
        if let paddingBottom = configuration.styles?.toolbar.paddingBottom{
            configurationToolbarProps.paddingBottom = paddingBottom
        }
        if let paddingLeft = configuration.styles?.toolbar.paddingLeft{
            configurationToolbarProps.paddingLeft = paddingLeft
        }
        if let paddingRight = configuration.styles?.toolbar.paddingRight{
            configurationToolbarProps.paddingRight = paddingRight
        }
        if let paddingTop = configuration.styles?.toolbar.paddingTop{
            configurationToolbarProps.paddingTop = paddingTop
        }
        if let assistantStateFontFamily = configuration.styles?.toolbar.assistantStateFontFamily{
            configurationToolbarProps.assistantStateFontFamily = assistantStateFontFamily
        }
        if let assistantStateFontSize = configuration.styles?.toolbar.assistantStateFontSize{
            configurationToolbarProps.assistantStateFontSize = assistantStateFontSize
        }
        if let assistantStateTextColor = configuration.styles?.toolbar.assistantStateTextColor{
            configurationToolbarProps.assistantStateTextColor = assistantStateTextColor
        }
        if let drawerSpeechHeight = configuration.styles?.toolbar.drawerSpeechHeight{
            configurationToolbarProps.drawerSpeechHeight = drawerSpeechHeight
        }
        if let drawerTextHeight = configuration.styles?.toolbar.drawerTextHeight{
            configurationToolbarProps.drawerTextHeight = drawerTextHeight
        }
        if let equalizerColor = configuration.styles?.toolbar.equalizerColor{
            configurationToolbarProps.equalizerColor = equalizerColor
        }
        if let fullSpeechResultTextColor = configuration.styles?.toolbar.fullSpeechResultTextColor{
            configurationToolbarProps.fullSpeechResultTextColor = fullSpeechResultTextColor
        }
        if let helpText = configuration.styles?.toolbar.helpText{
            configurationToolbarProps.helpText = helpText
        }
        if let helpTextFontColor = configuration.styles?.toolbar.helpTextFontColor{
            configurationToolbarProps.helpTextFontColor = helpTextFontColor
        }
        if let helpTextFontFamily = configuration.styles?.toolbar.helpTextFontFamily{
            configurationToolbarProps.helpTextFontFamily = helpTextFontFamily
        }
        if let helpTextFontSize = configuration.styles?.toolbar.helpTextFontSize{
            configurationToolbarProps.helpTextFontSize = helpTextFontSize
        }
        if let micActiveColor = configuration.styles?.toolbar.micActiveColor{
            configurationToolbarProps.micActiveColor = micActiveColor
        }
        if let micActiveHighlightColor = configuration.styles?.toolbar.micActiveHighlightColor{
            configurationToolbarProps.micActiveHighlightColor = micActiveHighlightColor
        }
        if let micActiveImage = configuration.styles?.toolbar.micActiveImage{
            configurationToolbarProps.micActiveImage = micActiveImage
        }
        if let micBorderRadius = configuration.styles?.toolbar.micBorderRadius{
            configurationToolbarProps.micBorderRadius = micBorderRadius
        }
        if let micImageBorderColor = configuration.styles?.toolbar.micImageBorderColor{
            configurationToolbarProps.micImageBorderColor = micImageBorderColor
        }
        if let micImageBorderWidth = configuration.styles?.toolbar.micImageBorderWidth{
            configurationToolbarProps.micImageBorderWidth = micImageBorderWidth
        }
        if let micImageHeight = configuration.styles?.toolbar.micImageHeight{
            configurationToolbarProps.micImageHeight = micImageHeight
        }
        if let micImagePadding = configuration.styles?.toolbar.micImagePadding{
            configurationToolbarProps.micImagePadding = micImagePadding
        }
        if let micImageWidth = configuration.styles?.toolbar.micImageWidth{
            configurationToolbarProps.micImageWidth = micImageWidth
        }
        if let micInactiveColor = configuration.styles?.toolbar.micInactiveColor{
            configurationToolbarProps.micInactiveColor = micInactiveColor
        }
        if let micInactiveHighlightColor = configuration.styles?.toolbar.micInactiveHighlightColor{
            configurationToolbarProps.micInactiveHighlightColor = micInactiveHighlightColor
        }
        if let partialSpeechResultFontFamily = configuration.styles?.toolbar.partialSpeechResultFontFamily{
            configurationToolbarProps.partialSpeechResultFontFamily = partialSpeechResultFontFamily
        }
        if let partialSpeechResultTextColor = configuration.styles?.toolbar.partialSpeechResultTextColor{
            configurationToolbarProps.partialSpeechResultTextColor = partialSpeechResultTextColor
        }
        if let micInactiveImage = configuration.styles?.toolbar.micInactiveImage{
            configurationToolbarProps.micInactiveImage = micInactiveImage
        }
        if let partialSpeechResultFontSize = configuration.styles?.toolbar.partialSpeechResultFontSize{
            configurationToolbarProps.partialSpeechResultFontSize = partialSpeechResultFontSize
        }
        if let placeholder = configuration.styles?.toolbar.placeholder{
            configurationToolbarProps.placeholder = placeholder
        }
        if let sendActiveColor = configuration.styles?.toolbar.sendActiveColor{
            configurationToolbarProps.sendActiveColor = sendActiveColor
        }
        if let sendActiveImage = configuration.styles?.toolbar.sendActiveImage{
            configurationToolbarProps.sendActiveImage = sendActiveImage
        }
        if let sendImageHeight = configuration.styles?.toolbar.sendImageHeight{
            configurationToolbarProps.sendImageHeight = sendImageHeight
        }
        if let sendImageWidth = configuration.styles?.toolbar.sendImageWidth{
            configurationToolbarProps.sendImageWidth = sendImageWidth
        }
        if let sendInactiveColor = configuration.styles?.toolbar.sendInactiveColor{
            configurationToolbarProps.sendInactiveColor = sendInactiveColor
        }
        if let sendInactiveImage = configuration.styles?.toolbar.sendInactiveImage{
            configurationToolbarProps.sendInactiveImage = sendInactiveImage
        }
        if let speakActiveTitleColor = configuration.styles?.toolbar.speakActiveTitleColor{
            configurationToolbarProps.speakActiveTitleColor = speakActiveTitleColor
        }
        if let speakFontFamily = configuration.styles?.toolbar.speakFontFamily{
            configurationToolbarProps.speakFontFamily = speakFontFamily
        }
        if let speakFontSize = configuration.styles?.toolbar.speakFontSize{
            configurationToolbarProps.speakFontSize = speakFontSize
        }
        if let speakInactiveTitleColor = configuration.styles?.toolbar.speakInactiveTitleColor{
            configurationToolbarProps.speakInactiveTitleColor = speakInactiveTitleColor
        }
        if let speechResultBoxBackgroundColor = configuration.styles?.toolbar.speechResultBoxBackgroundColor{
            configurationToolbarProps.speechResultBoxBackgroundColor = speechResultBoxBackgroundColor
        }
        if let textInputActiveLineColor = configuration.styles?.toolbar.textInputActiveLineColor{
            configurationToolbarProps.textInputActiveLineColor = textInputActiveLineColor
        }
        if let textInputCursorColor = configuration.styles?.toolbar.textInputCursorColor{
            configurationToolbarProps.textInputCursorColor = textInputCursorColor
        }
        if let textInputLineColor = configuration.styles?.toolbar.textInputLineColor{
            configurationToolbarProps.textInputLineColor = textInputLineColor
        }
        if let textboxActiveHighlightColor = configuration.styles?.toolbar.textboxActiveHighlightColor{
            configurationToolbarProps.textboxActiveHighlightColor = textboxActiveHighlightColor
        }
        if let textInputTextColor = configuration.styles?.toolbar.textInputTextColor{
            configurationToolbarProps.textInputTextColor = textInputTextColor
        }
        if let textboxFontFamily = configuration.styles?.toolbar.textboxFontFamily{
            configurationToolbarProps.textboxFontFamily = textboxFontFamily
        }
        if let textboxFontSize = configuration.styles?.toolbar.textboxFontSize{
            configurationToolbarProps.textboxFontSize = textboxFontSize
        }
        if let textboxInactiveHighlightColor = configuration.styles?.toolbar.textboxInactiveHighlightColor{
            configurationToolbarProps.textboxInactiveHighlightColor = textboxInactiveHighlightColor
        }
        if let typeActiveTitleColor = configuration.styles?.toolbar.typeActiveTitleColor{
            configurationToolbarProps.typeActiveTitleColor = typeActiveTitleColor
        }
        if let typeFontSize = configuration.styles?.toolbar.typeFontSize{
            configurationToolbarProps.typeFontSize = typeFontSize
        }
        if let typeFontFamily = configuration.styles?.toolbar.typeFontFamily{
            configurationToolbarProps.typeFontFamily = typeFontFamily
        }
        if let typeInactiveTitleColor = configuration.styles?.toolbar.typeInactiveTitleColor{
            configurationToolbarProps.typeInactiveTitleColor = typeInactiveTitleColor
        }
    }
}
