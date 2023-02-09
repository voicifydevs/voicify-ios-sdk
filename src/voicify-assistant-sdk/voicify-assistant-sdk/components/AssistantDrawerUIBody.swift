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
    @EnvironmentObject var configurationBodyProps: ConfigurationBodyProps
    @EnvironmentObject var configurationSettingsProps: ConfigurationSettingsProps
    public var voicifySTT: VoicifySTTProvider
    public var voicifyTTS: VoicifyTTSProivder
    public var voicifyAssistant: VoicifyAssistant
    public var bodyProps: BodyProps? = nil
    public var assistantSettings: AssistantSettingsProps? = nil
    @State var hintsParams: HintsViewParameters = HintsViewParameters()
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
                                        KFImage(URL(string: bodyProps?.assistantImage ?? configurationBodyProps.assistantImage ?? "https://voicify-dev-files.s3.amazonaws.com/52dfe3a1-b44e-4ff1-ac02-04f0a139cd51/f78ab9db-6708-4e16-a247-ef0a93aeb79f/voicify-logo.png"))
                                            .resizable()
                                            .renderingMode(!(bodyProps?.assistantImageColor ??  configurationBodyProps.assistantImageColor ?? "").isEmpty ? .template : .none)
                                            .foregroundColor(Color.init(hex: bodyProps?.assistantImageColor ??  configurationBodyProps.assistantImageColor ?? ""))
                                            .cornerRadius(CGFloat(bodyProps?.assistantImageBorderRadius ??  configurationBodyProps.assistantImageBorderRadius ?? 20))
                                            .padding(.all, CGFloat(bodyProps?.assistantImagePadding ?? 0))
                                            .overlay(RoundedRectangle(cornerRadius: CGFloat(bodyProps?.assistantImageBorderRadius ??  configurationBodyProps.assistantImageBorderRadius ?? 20)).stroke(Color.init(hex: bodyProps?.assistantImageBorderColor ??  configurationBodyProps.assistantImageBorderColor ?? "#00000000")!, lineWidth: CGFloat(bodyProps?.assistantImageBorderWidth ??  configurationBodyProps.assistantImageBorderWidth ?? 0)))
                                            .frame(width: CGFloat(bodyProps?.assistantImageWidth ?? configurationBodyProps.assistantImageWidth ?? 30), height: CGFloat(bodyProps?.assistantImageHeight ??  configurationBodyProps.assistantImageHeight ?? 30))
                                            .background(Color.init(hex: bodyProps?.assistantImageBackgroundColor ??  configurationBodyProps.assistantImageBackgroundColor ?? "#00000000"))
                                            .cornerRadius(CGFloat(bodyProps?.assistantImageBorderRadius ??  configurationBodyProps.assistantImageBorderRadius ?? 20))
                                        Spacer()
                                    }
                                    VStack{
                                        Text(.init(message.text) )
                                            .accessibilityIdentifier("messageReceivedText")
                                            .foregroundColor(Color.init(hex: bodyProps?.messageReceivedTextColor ??  configurationBodyProps.messageReceivedTextColor ?? "#000000"))
                                            .font(.custom(bodyProps?.messageReceivedFontFamily ??  configurationBodyProps.messageReceivedFontFamily ?? "SF Pro" , size: CGFloat(bodyProps?.messageReceivedFontSize ??  configurationBodyProps.messageReceivedFontSize ?? 14)))
                                            .padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6))
                                            .background(RoundedCorners(tl: CGFloat(bodyProps?.messageReceivedBorderTopLeftRadius ??  configurationBodyProps.messageReceivedBorderTopLeftRadius ?? 0), tr: CGFloat(bodyProps?.messageReceivedBorderTopRightRadius ??  configurationBodyProps.messageReceivedBorderTopRightRadius ?? 10), bl: CGFloat(bodyProps?.messageReceivedBorderBottomLeftRadius ??  configurationBodyProps.messageReceivedBorderBottomLeftRadius ?? 10), br: CGFloat(bodyProps?.messageReceivedBorderBottomRightRadius ??  configurationBodyProps.messageReceivedBorderBottomRightRadius ?? 10)).stroke(Color.init(hex: bodyProps?.messageReceivedBorderColor ??  configurationBodyProps.messageReceivedBorderColor ?? "#CBCCD2")!, lineWidth: CGFloat(bodyProps?.messageReceivedBorderWidth ??  configurationBodyProps.messageReceivedBorderWidth ?? 1)))
                                            .background(RoundedCorners(tl: CGFloat(bodyProps?.messageReceivedBorderTopLeftRadius ??  configurationBodyProps.messageReceivedBorderTopLeftRadius ?? 0), tr: CGFloat(bodyProps?.messageReceivedBorderTopRightRadius ??  configurationBodyProps.messageReceivedBorderTopRightRadius ?? 10), bl: CGFloat(bodyProps?.messageReceivedBorderBottomLeftRadius ??  configurationBodyProps.messageReceivedBorderBottomLeftRadius ?? 10), br: CGFloat(bodyProps?.messageReceivedBorderBottomRightRadius ??  configurationBodyProps.messageReceivedBorderBottomRightRadius ?? 10))
                                                .fill(Color.init(hex: bodyProps?.messageReceivedBackgroundColor ??  configurationBodyProps.messageReceivedBackgroundColor ?? "#0000000d")!))
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
                                        .font(.custom(bodyProps?.messageSentFontFamily ??  configurationBodyProps.messageSentFontFamily ?? "SF Pro" , size: CGFloat(bodyProps?.messageSentFontSize ?? configurationBodyProps.messageSentFontSize ?? 14)))
                                        .foregroundColor(Color.init(hex:bodyProps?.messageSentTextColor ??  configurationBodyProps.messageSentTextColor ?? "#ffffff"))
                                        .padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6))
                                        .background(RoundedCorners(tl: CGFloat(bodyProps?.messageSentBorderTopLeftRadius ??  configurationBodyProps.messageSentBorderTopLeftRadius ?? 8), tr: CGFloat(bodyProps?.messageSentBorderTopRightRadius ??  configurationBodyProps.messageSentBorderTopRightRadius ?? 0), bl: CGFloat(bodyProps?.messageSentBorderBottomLeftRadius ??  configurationBodyProps.messageSentBorderBottomLeftRadius ?? 8), br: CGFloat(bodyProps?.messageSentBorderBottomRightRadius ??  configurationBodyProps.messageSentBorderBottomRightRadius ?? 8)).stroke(Color.init(hex: bodyProps?.messageSentBorderColor ??  configurationBodyProps.messageSentBorderColor ?? "#00000000")!, lineWidth: CGFloat(bodyProps?.messageSentBorderWidth ??  configurationBodyProps.messageSentBorderWidth ?? 0)))
                                        .background(RoundedCorners(tl: CGFloat(bodyProps?.messageSentBorderTopLeftRadius ??  configurationBodyProps.messageSentBorderTopLeftRadius ?? 8), tr: CGFloat(bodyProps?.messageSentBorderTopRightRadius ??  configurationBodyProps.messageSentBorderTopRightRadius ?? 0), bl: CGFloat(bodyProps?.messageSentBorderBottomLeftRadius ??  configurationBodyProps.messageSentBorderBottomLeftRadius ?? 8), br: CGFloat(bodyProps?.messageSentBorderBottomRightRadius ??  configurationBodyProps.messageSentBorderBottomRightRadius ?? 8))
                                            .fill(Color.init(hex: bodyProps?.messageSentBackgroundColor ?? configurationBodyProps.messageSentBackgroundColor ?? "#00000080")!))
                                }
                                .padding(.leading, 50)
                                .padding(.top, 30)
                            }
                        }
                    }
                    .padding(.top, CGFloat(bodyProps?.paddingTop ?? configurationBodyProps.paddingTop ?? 20))
                    .padding(.bottom, CGFloat(bodyProps?.paddingBottom ?? configurationBodyProps.paddingBottom ?? 10))
                    .padding(.leading, CGFloat(bodyProps?.paddingLeft ?? configurationBodyProps.paddingLeft ?? 20))
                    .padding(.trailing, CGFloat(bodyProps?.paddingRight ?? configurationBodyProps.paddingRight ?? 20))
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
                                        .font(.custom(hintsParams.font , size: CGFloat(hintsParams.fontSize)))
                                        .foregroundColor(Color.init(hex: hintsParams.foregroundColor))
                                        .padding(EdgeInsets(top: CGFloat(hintsParams.paddingTop), leading: CGFloat(hintsParams.paddingLeft), bottom: CGFloat(hintsParams.paddingBottom), trailing: CGFloat(hintsParams.paddingRight)))
                                        .background(Color.init(hex: bodyProps?.hintsBackgroundColor ??  configurationBodyProps.hintsBackgroundColor ?? "#ffffff"))
                                        .cornerRadius(CGFloat(bodyProps?.hintsBorderRadius ?? configurationBodyProps.hintsBorderRadius ?? 20))
                                        .frame(minWidth: CGFloat(80))
                                        .overlay(RoundedRectangle(cornerRadius: CGFloat(bodyProps?.hintsBorderRadius ??  configurationBodyProps.hintsBorderRadius ?? 20)).strokeBorder(Color.init(hex: bodyProps?.hintsBorderColor ?? configurationBodyProps.hintsBorderColor ?? "#CCCCCC")!, lineWidth: CGFloat(bodyProps?.hintsBorderWidth ?? configurationBodyProps.hintsBorderWidth ?? 1.5)))
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
        .border(width: CGFloat(bodyProps?.borderTopWidth ?? configurationBodyProps.borderTopWidth ?? 1.5), edges: [.top], color: Color.init(hex: bodyProps?.borderTopColor ??  configurationBodyProps.borderTopColor ?? "cbccd2")!)
        .border(width: CGFloat(bodyProps?.borderBottomWidth ?? configurationBodyProps.borderBottomWidth ?? 1.5), edges: [.bottom], color: Color.init(hex: bodyProps?.borderBottomColor ?? configurationBodyProps.borderBottomColor ?? "cbccd2")!)
        .background(Color(hex: !(bodyProps?.backgroundColor ?? "").isEmpty ? bodyProps?.backgroundColor ?? "" :
                            !(configurationBodyProps.backgroundColor ?? "").isEmpty ? configurationBodyProps.backgroundColor ?? "" : !(assistantSettings?.backgroundColor ?? "").isEmpty ? assistantSettings?.backgroundColor ?? ""
                          :!(configurationSettingsProps.backgroundColor ?? "").isEmpty ? configurationSettingsProps.backgroundColor ?? "" : "#F4F4F6"))
        .onAppear{
            //have to map prop logic outside of view modifiers to avoid compile error "unable to type check in time"
            hintsParams =  HintsViewParameters(
                font: bodyProps?.hintsFontFamily ?? configurationBodyProps.hintsFontFamily ?? "SF Pro",
                fontSize: bodyProps?.hintsFontSize ?? configurationBodyProps.hintsFontSize ?? 14,
                foregroundColor: bodyProps?.hintsTextColor ?? configurationBodyProps.hintsTextColor ?? "#000000",
                paddingTop: bodyProps?.hintsPaddingTop ?? configurationBodyProps.hintsPaddingTop ?? 8,
                paddingRight: bodyProps?.hintsPaddingBottom ?? configurationBodyProps.hintsPaddingBottom ?? 8,
                paddingBottom: bodyProps?.hintsPaddingRight ?? configurationBodyProps.hintsPaddingRight ??  8,
                paddingLeft: bodyProps?.hintsPaddingLeft ?? configurationBodyProps.hintsPaddingLeft ?? 8
            )
        }
    }
}
