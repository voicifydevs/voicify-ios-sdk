//
//  ContentView.swift
//  voicify-assistant-sample
//
//  Created by Alex Dunn on 5/10/22.
//

import SwiftUI
import voicify_assistant_sdk
struct ContentView: View {
//    var device: CustomAssistantDevice = CustomAssistantDevice(id: "", name: "", supportsVideo: false, supportsForegroundImage: false, supportsBackgroundImage: false, supportsAudio: false, supportsSsml: false, supportsDisplayText: false, supportsVoiceInput: false, supportsTextInput: false)
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button("Click me to open \nthe assistant"){
                    
                }
            }
            Spacer()
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
