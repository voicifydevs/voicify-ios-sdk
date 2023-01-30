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
    @Binding var showNoInternetCloseButton: Bool
    @EnvironmentObject var configurationHeaderProps: ConfigurationHeaderProps
    @EnvironmentObject var configurationSettingsProps: ConfigurationSettingsProps
    public var headerProps: HeaderProps? = nil
    public var assistantSettings: AssistantSettingsProps? = nil
    
    public init(assistantIsOpen: Binding<Bool>, showNoInternetCloseButton: Binding<Bool>, headerProps: HeaderProps? = nil, assistantSettings: AssistantSettingsProps? = nil) {
        self._assistantIsOpen = assistantIsOpen
        self._showNoInternetCloseButton = showNoInternetCloseButton
        self.headerProps = headerProps
        self.assistantSettings = assistantSettings
    }

    var body: some View {
        HStack{
            VStack{
                KFImage(URL(string: headerProps?.assistantImage ?? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/eb7d2538-a3dc-4304-b58c-06fdb34e9432/Mark-Color-3-.png"))
                    .resizable()
                    .renderingMode(!(headerProps?.assistantImageColor ?? configurationHeaderProps.assistantImageColor ?? "").isEmpty ? .template : .none)
                    .foregroundColor(Color.init(hex: headerProps?.assistantImageColor ?? configurationHeaderProps.assistantImageColor ?? ""))
                    .frame(width: CGFloat(headerProps?.assistantImageWidth ?? configurationHeaderProps.assistantImageWidth ?? 32), height: CGFloat(headerProps?.assistantImageHeight ?? configurationHeaderProps.assistantImageHeight ?? 32))
                    .fixedSize()
            }
            .padding(.all, 4)
            .overlay(RoundedRectangle(cornerRadius: CGFloat(headerProps?.assistantImageBorderRadius ?? configurationHeaderProps.assistantImageBorderRadius ?? 20)).stroke(Color.init(hex: headerProps?.assistantImageBorderColor ?? configurationHeaderProps.assistantImageBorderColor ?? "#8F97A1")!, lineWidth: CGFloat(headerProps?.assistantImageBorderWidth ?? configurationHeaderProps.assistantImageBorderWidth ?? 2)))
            .background(Color.init(hex: headerProps?.assistantImageBackgroundColor ?? configurationHeaderProps.assistantImageBackgroundColor ?? "#ffffff"))
            .cornerRadius(CGFloat(headerProps?.assistantImageBorderRadius ?? configurationHeaderProps.assistantImageBorderRadius ?? 20))
            
            Text(headerProps?.assistantName ?? configurationHeaderProps.assistantName ?? "Voicify Assistant")
                .font(.custom(headerProps?.fontFamily ?? configurationHeaderProps.fontFamily ?? "SF Pro" , size: CGFloat(headerProps?.fontSize ?? configurationHeaderProps.fontSize ?? 18)))
                .foregroundColor(Color.init(hex: headerProps?.assistantNameTextColor ?? configurationHeaderProps.assistantNameTextColor ?? "#000000"))
                .padding(.leading, 4)
            
            Spacer()
            
            Button(action: {
                assistantIsOpen = false
            }){
                if(showNoInternetCloseButton)
                {
                    Image("remove-circle")
                }
                else
                {
                    KFImage(URL(string: headerProps?.closeAssistantButtonImage ?? configurationHeaderProps.closeAssistantButtonImage ?? "https://voicify-prod-files.s3.amazonaws.com/99a803b7-5b37-426c-a02e-63c8215c71eb/a6de04bb-e572-4a55-8cd9-1a7628285829/delete-2.png"))
                        .resizable()
                        .renderingMode(!(headerProps?.closeAssistantColor ?? configurationHeaderProps.closeAssistantColor ?? "").isEmpty ? .template : .none)
                        .foregroundColor(Color.init(hex: headerProps?.closeAssistantColor ?? configurationHeaderProps.closeAssistantColor ?? ""))
                        .padding(.all, 4)
                        .overlay(RoundedRectangle(cornerRadius: CGFloat(headerProps?.closeAssistantButtonBorderRadius ?? configurationHeaderProps.closeAssistantButtonBorderRadius ?? 0)).stroke(Color.init(hex: headerProps?.closeAssistantButtonBorderColor ?? configurationHeaderProps.closeAssistantButtonBorderColor ?? "#00000000")!, lineWidth: CGFloat(headerProps?.closeAssistantButtonBorderWidth ?? configurationHeaderProps.closeAssistantButtonBorderWidth ?? 0)))
                        .frame(width: CGFloat(headerProps?.closeAssistantButtonImageWidth ?? configurationHeaderProps.closeAssistantButtonImageWidth ?? 35), height: CGFloat(headerProps?.closeAssistantButtonImageHeight ?? configurationHeaderProps.closeAssistantButtonImageHeight ?? 35))
                        .background(Color.init(hex: headerProps?.closeAssistantButtonBackgroundColor ?? configurationHeaderProps.closeAssistantButtonBackgroundColor ?? "#00000000"))
                        .cornerRadius(CGFloat(headerProps?.closeAssistantButtonBorderRadius ?? configurationHeaderProps.closeAssistantButtonBorderRadius ?? 0))
                }
            }
        }
        .padding(.leading, CGFloat(headerProps?.paddingLeft ?? configurationHeaderProps.paddingLeft ?? 20))
        .padding(.trailing, CGFloat(headerProps?.paddingRight ?? configurationHeaderProps.paddingRight ?? 20))
        .padding(.top, CGFloat(headerProps?.paddingTop ?? configurationHeaderProps.paddingTop ?? 50))
        .padding(.bottom, CGFloat(headerProps?.paddingBottom ?? configurationHeaderProps.paddingBottom ?? 20))
        .background(Color(hex: !(headerProps?.backgroundColor ?? "").isEmpty ? headerProps?.backgroundColor ?? "" :
                            !(configurationHeaderProps.backgroundColor ?? "").isEmpty ? configurationHeaderProps.backgroundColor ?? "" :!(assistantSettings?.backgroundColor ?? "").isEmpty ? assistantSettings?.backgroundColor ?? "" :!(configurationSettingsProps.backgroundColor ?? "").isEmpty ? configurationSettingsProps.backgroundColor ?? "" : "#ffffff"))
    }
}
