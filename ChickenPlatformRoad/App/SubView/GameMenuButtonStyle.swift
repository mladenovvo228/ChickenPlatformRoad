//
//  GameMenuButtonStyle.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 06/11/25.
//

import SwiftUI

struct GameMenuButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .customFont(size: 25, color: .white)
            .overlay {
                Divider()
                    .frame(height: 2)
                    .background(.white)
                    .padding(.top, screenHeight * 0.03)
                
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
