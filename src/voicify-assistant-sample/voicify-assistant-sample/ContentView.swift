//
//  ContentView.swift
//  voicify-assistant-sample
//
//  Created by Alex Dunn on 5/10/22.
//

import SwiftUI
import voicify_assistant_sdk
struct ContentView: View {
//    @StateObject var voicifySTT = VoicifySTTProvider()
//    @StateObject var voicifyTTS = VoicifyTTSProivder(settings: VoicifyTextToSpeechSettings(appId: "99a803b7-5b37-426c-a02e-63c8215c71eb", appKey: "MTAzM2RjNDEtMzkyMC00NWNhLThhOTYtMjljMDc3NWM5NmE3", voice: "", serverRootUrl: "https://assistant.voicify.com", provider: "Google"))
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

    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button("Click me to open \nthe assistant"){
                    voicifyAsssitant.initializeAndStart()
                    voicifyAsssitant.startNewSession()
                    voicifyAsssitant.makeTextRequest(text: "play how we got here", inputType: "Text")
                    voicifyAsssitant.onRequestStarted {(request: CustomAssistantRequest) -> Void in
                        
                    }
                    voicifyAsssitant.onResponseReceived{(response: CustomAssistantResponse) -> Void in
                        print ("HERE IS THE RESPONSE!!!!")
                    }
                    voicifyAsssitant.onEffect(effectName: "Play"){(data: Any) -> Void in
                        print("WE GOT A PLAY EFFECT HERE!!!!")
                        print(data)
                    }
                        
//                    voicifySTT.reset()
//                    if(!isListening)
//                    {
//                        voicifySTT.startListening()
//                    }
//                    else {
//                        voicifySTT.stopListening()
//                    }
//                    if(isSpeaking)
//                    {
//                        voicifyTTS.stop()
//                    }
                   
                }
                Text(inputSpeech).font(.system(size: 34))
                Text(String(speechVolume)).font(.system(size: 34))
                Text(speechEndedMessage).font(.system(size: 34))
            }
            Spacer()
        }.onAppear{
//            voicifySTT.initialize(locale: "en-US")
//            voicifyTTS.initialize(locale: "en-US")
//            voicifyTTS.addFinishListener {() -> Void in
//                speechEndedMessage = "speech has ended"
//            }
//            voicifySTT.addFinalResultListener{(fullResult: String) -> Void  in
//                inputSpeech = fullResult
//                isSpeaking = true
//                voicifyTTS.speakSsml(ssml: fullResult)
//            }
//            voicifySTT.addPartialListener{(partialResult:String) -> Void in
//                inputSpeech = partialResult
//            }
//            voicifySTT.addVolumeListener{(volume: Float) -> Void in
//                speechVolume = volume
//            }
//            voicifySTT.addStartListener {
//                isListening = true
//            }
//            voicifySTT.addEndListener {
//                isListening = false
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
