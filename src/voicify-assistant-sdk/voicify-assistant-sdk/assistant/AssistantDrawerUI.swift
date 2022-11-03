//
//  AssistantDrawerUI.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 11/3/22.
//

import SwiftUI

public struct AssistantDrawerUI: View {
    var assistantSettingsProps: AssistantSettingsProps
    @Binding var assistantIsOpen: Bool
    
    public init(assistantSettings: AssistantSettingsProps, assistantIsOpen: Binding<Bool>) {
        self.assistantSettingsProps = assistantSettings
        self._assistantIsOpen = assistantIsOpen
    }
    
    public var body: some View {
        VStack{
            
        }
        .sheet(isPresented: $assistantIsOpen){
            VStack{
                Button("Click me to close \nthe assistant"){
                    assistantIsOpen = false
                }
            }
        }
    }
}

//struct AssistantDrawerUI_Previews: PreviewProvider {
//    static var previews: some View {
//        //AssistantDrawerUI(assistantSettingsProps: <#T##AssistantSettingsProps#>)
//    }
//}
