//
//  MainView.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 03/11/25.
//

import SwiftUI

struct MainView: View {
    @State private var showAllMenu = false
    @State private var showInfo = false
    
    var body: some View {
        ZStack {
            Image("bg_loading")
                .resizable()
                .ignoresSafeArea()
            
            Image("chicken1")
                .resizable()
                .ignoresSafeArea()
                .scaledToFit()
                .frame(height: screenHeight * 0.6)
            
            VStack {
                HStack {
                    Button("") {
                        withAnimation {
                            showInfo = true
                        }
                        
                    }
                    .buttonStyle(SubButtonStyle(imageName: "info"))
                    
                    Spacer()
                    
                    Button("") {
                        withAnimation {
                            showAllMenu = true
                        }
                    }
                    .buttonStyle(SubButtonStyle(imageName: "menu"))
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                Button("Play") {
                    
                }
                .buttonStyle(MainButtonStyle(isBig: true))
                .padding(.bottom, screenHeight * 0.053)
            }
        }
        .fullScreenCover(isPresented: $showInfo, content: {
            InfoView()
        })
    }
}

#Preview {
    MainView()
}
