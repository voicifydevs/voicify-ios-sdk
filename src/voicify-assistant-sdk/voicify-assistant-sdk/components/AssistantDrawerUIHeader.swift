//
//  AssistantDrawerUIHeader.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 12/13/22.
//

import SwiftUI
import Kingfisher

struct AssistantDrawerUIHeader: View {
    @Binding var assistantIsOpen: Bool
    public var headerProps: HeaderProps? = nil
    
    public init(assistantIsOpen: Binding<Bool>, headerProps: HeaderProps? = nil ) {
        self._assistantIsOpen = assistantIsOpen
        self.headerProps = headerProps
    }

    var body: some View {
        HStack{
            VStack{
                KFImage(URL(string: headerProps?.assistantImage ?? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/eb7d2538-a3dc-4304-b58c-06fdb34e9432/Mark-Color-3-.png"))
                    .resizable()
                    .renderingMode(!(headerProps?.assistantImageColor ?? "").isEmpty ? .template : .none)
                    .foregroundColor(Color.init(hex: headerProps?.assistantImageColor ?? ""))
                    .frame(width: CGFloat(headerProps?.assistantImageWidth ?? 32), height: CGFloat(headerProps?.assistantImageHeight ?? 32))
                    .fixedSize()
            }
            .padding(.all, 4)
            .overlay(RoundedRectangle(cornerRadius: CGFloat(headerProps?.assistantImageBorderRadius ?? 20)).stroke(Color.init(hex: headerProps?.assistantImageBorderColor ?? "#8F97A1")!, lineWidth: CGFloat(headerProps?.assistantImageBorderWidth ?? 2)))
            .background(Color.init(hex: headerProps?.assistantImageBackgroundColor ?? "#ffffff"))
            .cornerRadius(CGFloat(headerProps?.assistantImageBorderRadius ?? 20))
            
            Text(headerProps?.assistantName ?? "Voicify Assistant")
                .font(.custom(headerProps?.fontFamily ?? "SF Pro" , size: CGFloat(headerProps?.fontSize ?? 18)))
                .foregroundColor(Color.init(hex: headerProps?.assistantNameTextColor ?? "#000000"))
                .padding(.leading, 4)
            
            Spacer()
            
            Button(action: {
                assistantIsOpen = false
            }){
                KFImage(URL(string: headerProps?.closeAssistantButtonImage ?? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/a6de04bb-e572-4a55-8cd9-1a7628285829/delete-2.png"))
                    .resizable()
                    .renderingMode(!(headerProps?.closeAssistantColor ?? "").isEmpty ? .template : .none)
                    .foregroundColor(Color.init(hex: headerProps?.closeAssistantColor ?? ""))
                    .padding(.all, 4)
                    .overlay(RoundedRectangle(cornerRadius: CGFloat(headerProps?.closeAssistantButtonBorderRadius ?? 0)).stroke(Color.init(hex: headerProps?.closeAssistantButtonBorderColor ?? "#00000000")!, lineWidth: CGFloat(headerProps?.closeAssistantButtonBorderWidth ?? 0)))
                    .frame(width: CGFloat(headerProps?.closeAssistantButtonImageWidth ?? 35), height: CGFloat(headerProps?.closeAssistantButtonImageHeight ?? 35))
                    .background(Color.init(hex: headerProps?.closeAssistantButtonBackgroundColor ?? "#00000000"))
                    .cornerRadius(CGFloat(headerProps?.closeAssistantButtonBorderRadius ?? 0))
            }
        }
        .padding(.leading, CGFloat(headerProps?.paddingLeft ?? 20))
        .padding(.trailing, CGFloat(headerProps?.paddingRight ?? 20))
        .padding(.top, CGFloat(headerProps?.paddingTop ?? 50))
        .padding(.bottom, CGFloat(headerProps?.paddingBottom ?? 20))
        .background(Color(hex: headerProps?.backgroundColor ?? "#ffffff"))
    }
}
