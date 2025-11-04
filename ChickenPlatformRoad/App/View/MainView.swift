//
//  MainView.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 03/11/25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var router: AppRouter
    
    @State private var pulse = false
    
    var body: some View {
        ZStack {
            Image("bg_loading")
                .resizable()
                .ignoresSafeArea()
            
            ZStack {
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [
                                Color.yellow.opacity(0.6),
                                Color.orange.opacity(0.0)
                            ]),
                            center: .center,
                            startRadius: 0,
                            endRadius: 300
                        )
                    )
                    .blur(radius: 80)
                    .scaleEffect(pulse ? 1.2 : 0.9)
                    .opacity(pulse ? 0.8 : 0.5)
                    .animation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true), value: pulse)
                
                Image("chicken1")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight * 0.6)
                    .shadow(color: .yellow.opacity(0.4), radius: 30, y: 10)
                    .scaleEffect(pulse ? 1.05 : 0.95)
                    .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: pulse)
            }
            .onAppear {
                pulse = true
            }
            
            VStack {
                HStack {
                    Button("") {
                        withAnimation {
                            router.route = .info
                        }
                    }
                    .buttonStyle(SubButtonStyle(imageName: "info"))
                    
                    Spacer()
                    
                    Button("") {
                        withAnimation {
                            router.route = .menu
                        }
                    }
                    .buttonStyle(SubButtonStyle(imageName: "menu"))
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                Button("Play") { }
                    .buttonStyle(MainButtonStyle(isBig: true))
                    .padding(.bottom, screenHeight * 0.053)
            }
        }
    }
}


#Preview {
    MainView()
}
