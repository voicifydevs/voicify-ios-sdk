//
//  AssistantDrawerUIBody.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 12/13/22.
//

import SwiftUI
import Kingfisher

struct AssistantDrawerUIBody: View {
    @Binding var messages: Array<Message>
    @Binding var isUsingSpeech: Bool
    @Binding var keyboardToggled: Bool
    @Binding var hints: Array<Hint>
    @Binding var inputText: String
    @Binding var inputSpeech: String
    public var voicifySTT: VoicifySTTProvider
    public var voicifyTTS: VoicifyTTSProivder
    public var voicifyAssistant: VoicifyAssistant
    public var bodyProps: BodyProps? = nil
    public var assistantSettings: AssistantSettingsProps? = nil
    public init(messages: Binding<Array<Message>>, isUsingSpeech: Binding<Bool>, keyboardToggled: Binding<Bool>, hints: Binding<Array<Hint>>, inputText: Binding<String>, inputSpeech: Binding<String>, voicifySTT: VoicifySTTProvider, voicifyTTS: VoicifyTTSProivder, voicifyAssistant: VoicifyAssistant, bodyProps: BodyProps? = nil, assistantSettings: AssistantSettingsProps? = nil) {
        self._messages = messages
        self._isUsingSpeech = isUsingSpeech
        self._keyboardToggled = keyboardToggled
        self._hints = hints
        self._inputText = inputText
        self._inputSpeech = inputSpeech
        self.voicifySTT = voicifySTT
        self.voicifyTTS = voicifyTTS
        self.voicifyAssistant = voicifyAssistant
        self.bodyProps = bodyProps
        self.assistantSettings = assistantSettings
    }
    var body: some View {
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
                                            .renderingMode(!(bodyProps?.assistantImageColor ?? "").isEmpty ? .template : .none)
                                            .foregroundColor(Color.init(hex: bodyProps?.assistantImageColor ?? ""))
                                            .padding(.all, 4)
                                            .overlay(RoundedRectangle(cornerRadius: CGFloat(bodyProps?.assistantImageBorderRadius ?? 20)).stroke(Color.init(hex: bodyProps?.assistantImageBorderColor ?? "#8F97A1")!, lineWidth: CGFloat(bodyProps?.assistantImageBorderWidth ?? 2)))
                                            .frame(width: CGFloat(bodyProps?.assistantImageWidth ?? 35), height: CGFloat(bodyProps?.assistantImageHeight ?? 35))
                                            .background(Color.init(hex: bodyProps?.assistantImageBackgroundColor ?? "#ffffff"))
                                            .cornerRadius(CGFloat(bodyProps?.assistantImageBorderRadius ?? 20))
                                        Spacer()
                                    }
                                    VStack{
                                        Text(.init(message.text) )
                                            .accessibilityIdentifier("messageReceivedText")
                                            .foregroundColor(Color.init(hex: bodyProps?.messageReceivedTextColor ?? "#000000"))
                                            .font(.custom(bodyProps?.messageReceivedFontFamily ?? "SF Pro" , size: CGFloat(bodyProps?.messageReceivedFontSize ?? 14)))
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
                                        .accessibilityIdentifier("messageSentText")
                                        .font(.custom(bodyProps?.messageSentFontFamily ?? "SF Pro" , size: CGFloat(bodyProps?.messageSentFontSize ?? 14)))
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
                        if(messages.count > 0)
                        {
                            if(messages[messages.count - 1].origin == "Received")
                            {
                                Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) { timer in
                                    value.scrollTo(messages[messages.count - 1].id)
                                }
                            }
                        }
                    }
                )
                .onChange(of: isUsingSpeech, perform: { _ in
                        if(messages.count > 0)
                        {
                            if(messages[messages.count - 1].origin == "Received")
                            {
                                Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) { timer in
                                    value.scrollTo(messages[messages.count - 1].id)
                                }
                            }
                        }
                    }
                )
                .onChange(of: keyboardToggled, perform: { _ in
                        if(messages.count > 0)
                        {
                            if(messages[messages.count - 1].origin == "Received")
                            {
                                Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) { timer in
                                    value.scrollTo(messages[messages.count - 1].id)
                                }
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
                                    voicifyAssistant.makeTextRequest(text: hint.text, inputType: "Text")
                                    hints = []
                                }){
                                    Text(hint.text)
                                        .lineLimit(1)
                                        .font(.custom(bodyProps?.hintsFontFamily ?? "SF Pro" , size: CGFloat(bodyProps?.hintsFontSize ?? 14)))
                                        .foregroundColor(Color.init(hex: bodyProps?.hintsTextColor ?? "#000000"))
                                        .padding(EdgeInsets(top: CGFloat(bodyProps?.hintsPaddingTop ?? 8), leading: CGFloat(bodyProps?.hintsPaddingLeft ?? 8), bottom: CGFloat(bodyProps?.hintsPaddingBottom ?? 8), trailing: CGFloat(bodyProps?.hintsPaddingRight ??  8)))
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
        .background(Color(hex: !(bodyProps?.backgroundColor ?? "").isEmpty ? bodyProps?.backgroundColor ?? "" : !(assistantSettings?.backgroundColor ?? "").isEmpty ? assistantSettings?.backgroundColor ?? "" : "#F4F4F6"))
    }
}
