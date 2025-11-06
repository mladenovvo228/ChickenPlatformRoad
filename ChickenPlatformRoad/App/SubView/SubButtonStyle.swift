//
//  SubButtonStyle.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 03/11/25.
//

import SwiftUI

struct SubButtonStyle: ButtonStyle {
    var imageName: String
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: imageName != "small_button" ? screenWidth * 0.2 : screenWidth * 0.25)
            
            configuration.label
                .customFont(size: screenHeight * 0.038)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
        }
        .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
        .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
        .simultaneousGesture(
            TapGesture().onEnded {
                VibrationManager.vibration()
            }
        )
    }
}
