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
                .frame(width: screenWidth * 0.2)
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
