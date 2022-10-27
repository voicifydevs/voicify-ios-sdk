//
//  ContentView.swift
//  voicify-assistant-sample
//
//  Created by Alex Dunn on 5/10/22.
//

import SwiftUI
import voicify_assistant_sdk
struct ContentView: View {
    @StateObject var voicifySTT = VoicifySTTProvider()
    @State var inputSpeech = ""
    @State var speechVolume: Double = 0
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button("Click me to open \nthe assistant"){
                    voicifySTT.reset()
                    voicifySTT.startListening()
                }
                Text(inputSpeech).font(.system(size: 34))
                Text(String(speechVolume)).font(.system(size: 34))
                
                
            }
            Spacer()
        }.onAppear{
            voicifySTT.initialize(locale: "en-US")
            voicifySTT.addFinalResultListener{(fullResult: String) -> Void  in
                inputSpeech = fullResult
            }
            voicifySTT.addPartialListener{(partialResult:String) -> Void in
                inputSpeech = partialResult
            }
            voicifySTT.addVolumeListener{(volume: Double) -> Void in
                speechVolume = volume
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
