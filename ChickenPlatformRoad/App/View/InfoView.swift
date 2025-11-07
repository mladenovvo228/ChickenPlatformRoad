//
//  InfoView.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 03/11/25.
//

import SwiftUI

struct InfoView: View {
    @EnvironmentObject private var router: AppRouter
    var body: some View {
        ZStack {
            Image("bg_loading")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    
                    Button("") {
                        router.route = .main
                    }
                    .buttonStyle(SubButtonStyle(imageName: "back"))
                    
                    Spacer()
                    
                    
                }
                .padding(.horizontal, 20)
                .padding(.bottom, screenHeight * 0.07)
               
                
                VStack {
                    Text("How to play")
                        .customFont(size: titleFontSize)
                        .padding()
                    ScrollView {
                        VStack {
                            Text("Swipe on the screen to control the egg.")
                            
                            Image("egg1")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight * 0.1)
                            
                            Text("The goal is to collect yellow eggs that increase your score.")
                            
                            Image("egg_score")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight * 0.1)
                            
                            Text("The egg is affected by gravity and will gradually fall down.\n\nUse swipes up and sideways to keep the sphere on the platforms.\n\nPlatform move down with different speeds.")
                            
                            Image("platform")
                                .resizable()
                                .scaledToFit()
                            
                            Text("They contain eggs – collect them!")
                            
                            Image("egg_score")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight * 0.1)
                            
                            Text("Also they can contain coins. Collect them to buy new eggs in the shop.")
                            
                            Image("coin")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight * 0.1)
                            
                            Text("If you fall off the bottom of the screen – game over!\n\nThe higher the level, the faster the platforms move.")
                        }
                        .customFont(size: screenHeight * 0.02)
                        .padding(.horizontal)
                    }
                    .padding(.bottom)
                }
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.purpleRect)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.purpleRectStroke, lineWidth: 3)
                        )
                        .opacity(0.8)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 20)
                
            }
        }
    }
}

#Preview {
    InfoView()
}
