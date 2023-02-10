//
//  SpeakingAnimation.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 12/13/22.
//

import Foundation
import SwiftUI

public struct SpeakingAnimation: View {
    @Binding var isSpeaking: Bool
    @Binding var isFullScreen: Bool
    @Binding var animationValues: Array<CGFloat>
    @Binding var equalizerGradientColors: Array<Color>
    public var equalizerColor: String? = nil
    
    public init(isSpeaking: Binding<Bool>, isFullScreen: Binding<Bool>, animationValues: Binding<Array<CGFloat>>, equalizerColor: String? = nil, equalizerGradientColors: Binding<Array<Color>>) {
        self._isSpeaking = isSpeaking
        self._isFullScreen = isFullScreen
        self._animationValues = animationValues
        self._equalizerGradientColors = equalizerGradientColors
        self.equalizerColor = equalizerColor
    }
    
    public var body: some View {
        HStack{
            VStack{
                
            }
            .frame(width: 4, height: 1)
            .background(
                !equalizerGradientColors.isEmpty ?
                 LinearGradient(gradient: Gradient(colors: equalizerGradientColors), startPoint: .top, endPoint: .bottom)
                :
                    LinearGradient(gradient: Gradient(colors: [Color.init(hex: equalizerColor?.components(separatedBy: ",").count == 1 ? equalizerColor ?? "" : "#00000080")!]), startPoint: .top, endPoint: .bottom)
            )
            .scaleEffect(x: 1, y: isSpeaking ? animationValues[0] * 5 : 1, anchor: .bottom)
            .padding(.trailing, -10)
            VStack{
                
            }
            .frame(width: 4, height: 1)
            .background(
                !equalizerGradientColors.isEmpty ?
                 LinearGradient(gradient: Gradient(colors: equalizerGradientColors), startPoint: .top, endPoint: .bottom)
                :
                    LinearGradient(gradient: Gradient(colors: [Color.init(hex: equalizerColor?.components(separatedBy: ",").count == 1 ? equalizerColor ?? "" : "#00000080")!]), startPoint: .top, endPoint: .bottom)
            )
            .scaleEffect(x: 1, y: isSpeaking ? animationValues[1] * 10 : 1, anchor: .bottom)
            .padding(.trailing, -10)
            VStack{
                
            }
            .frame(width: 4, height: 1)
            .background(
                !equalizerGradientColors.isEmpty ?
                 LinearGradient(gradient: Gradient(colors: equalizerGradientColors), startPoint: .top, endPoint: .bottom)
                :
                    LinearGradient(gradient: Gradient(colors: [Color.init(hex: equalizerColor?.components(separatedBy: ",").count == 1 ? equalizerColor ?? "" : "#00000080")!]), startPoint: .top, endPoint: .bottom)
            )
            .scaleEffect(x: 1, y: isSpeaking ? animationValues[2] * 11 : 1, anchor: .bottom)
            .padding(.trailing, -10)
            VStack{
                
            }
            .frame(width: 4, height: 1)
            .background(
                !equalizerGradientColors.isEmpty ?
                 LinearGradient(gradient: Gradient(colors: equalizerGradientColors), startPoint: .top, endPoint: .bottom)
                :
                    LinearGradient(gradient: Gradient(colors: [Color.init(hex: equalizerColor?.components(separatedBy: ",").count == 1 ? equalizerColor ?? "" : "#00000080")!]), startPoint: .top, endPoint: .bottom)
            )
            .scaleEffect(x: 1, y: isSpeaking ? animationValues[3] * 13 : 1, anchor: .bottom)
            .padding(.trailing, -10)
            VStack{
                
            }
            .frame(width: 4, height: 1)
            .background(
                !equalizerGradientColors.isEmpty ?
                 LinearGradient(gradient: Gradient(colors: equalizerGradientColors), startPoint: .top, endPoint: .bottom)
                :
                    LinearGradient(gradient: Gradient(colors: [Color.init(hex: equalizerColor?.components(separatedBy: ",").count == 1 ? equalizerColor ?? "" : "#00000080")!]), startPoint: .top, endPoint: .bottom)
            )
            .scaleEffect(x: 1, y: isSpeaking ? animationValues[4] * 13 : 1, anchor: .bottom)
            .padding(.trailing, -10)
            VStack{
                
            }
            .frame(width: 4, height: 1)
            .background(
                !equalizerGradientColors.isEmpty ?
                 LinearGradient(gradient: Gradient(colors: equalizerGradientColors), startPoint: .top, endPoint: .bottom)
                :
                    LinearGradient(gradient: Gradient(colors: [Color.init(hex: equalizerColor?.components(separatedBy: ",").count == 1 ? equalizerColor ?? "" : "#00000080")!]), startPoint: .top, endPoint: .bottom)
            )
            .scaleEffect(x: 1, y: isSpeaking ? animationValues[5] * 11 : 1, anchor: .bottom)
            .padding(.trailing, -10)
            VStack{
                
            }
            .frame(width: 4, height: 1)
            .background(
                !equalizerGradientColors.isEmpty ?
                 LinearGradient(gradient: Gradient(colors: equalizerGradientColors), startPoint: .top, endPoint: .bottom)
                :
                    LinearGradient(gradient: Gradient(colors: [Color.init(hex: equalizerColor?.components(separatedBy: ",").count == 1 ? equalizerColor ?? "" : "#00000080")!]), startPoint: .top, endPoint: .bottom)
            )
            .scaleEffect(x: 1, y: isSpeaking ? animationValues[6] * 10 : 1, anchor: .bottom)
            .padding(.trailing, -10)
            VStack{
                
            }
            .frame(width: 4, height: 1)
            .background(
                !equalizerGradientColors.isEmpty ?
                 LinearGradient(gradient: Gradient(colors: equalizerGradientColors), startPoint: .top, endPoint: .bottom)
                :
                    LinearGradient(gradient: Gradient(colors: [Color.init(hex: equalizerColor?.components(separatedBy: ",").count == 1 ? equalizerColor ?? "" : "#00000080")!]), startPoint: .top, endPoint: .bottom)
            )
            .scaleEffect(x: 1, y: isSpeaking ? animationValues[7] * 5 : 1, anchor: .bottom)
        }
        .frame(minHeight: 10)
        .padding(.top, isFullScreen ? 36 : 0)
    }
}
