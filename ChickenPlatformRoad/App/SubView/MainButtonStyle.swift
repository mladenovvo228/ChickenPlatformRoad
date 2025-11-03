import SwiftUI

struct MainButtonStyle: ButtonStyle {
    var isBig: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Image("big_button")
                .resizable()
                .scaledToFit()
                .frame(width: isBig ? screenWidth * 0.66 : screenWidth * 0.5)
                
                
            
            configuration.label
                .customFont(size: isBig ? screenHeight * 0.065 : screenHeight * 0.058)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
        }
        .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
        .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}
