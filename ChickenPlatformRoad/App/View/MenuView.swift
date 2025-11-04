//
//  MenuView.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 03/11/25.
//

import SwiftUI

struct MenuView: View {
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
                    
                    CoinLabel(coins: 2)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, screenHeight * 0.07)
                
                Spacer()
                VStack {
                    Text("MENU")
                        .customFont(size: 40)
                        .padding()
                    ForEach(MenuButtonLabel.allCases, id: \.self) { item in
                        Button(item.rawValue) {
                            item.perform(router: router)
                        }
                        .buttonStyle(MainButtonStyle(isBig: false))
                    }
                }
                .padding(30)
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
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    MenuView()
}
