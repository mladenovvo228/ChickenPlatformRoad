import SwiftUI

struct MainButtonStyle: ButtonStyle {
    var isBig: Bool
    var isSmallerFont: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Image("big_button")
                .resizable()
                .scaledToFit()
                .frame(width: isBig ? screenWidth * 0.66 : screenWidth * 0.45)
            
            configuration.label
                .customFont(size: isBig ? (isSmallerFont ? screenHeight * 0.045 : screenHeight * 0.065) : screenHeight * 0.018)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
        }
        .simultaneousGesture(
            TapGesture().onEnded {
                VibrationManager.vibration()
            }
        )
        .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
        .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}
