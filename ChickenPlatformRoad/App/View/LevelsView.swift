//
//  LevelsView.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 05/11/25.
//

import SwiftUI

struct LevelsView: View {
    @EnvironmentObject private var router: AppRouter
    @AppStorage("highestUnlockedLevel") private var highestUnlockedLevel: Int = 1
    @EnvironmentObject private var shopVM: ShopViewModel
    private let totalLevels = 9
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
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
                    
                    CoinLabel(coins: shopVM.totalCoins)
                }
                .padding(.horizontal, 20)
                
                
                Text("Change level")
                    .customFont(size: 30)
                    .padding(.bottom, screenHeight * 0.07)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(1..<10) { index in
                        let unlocked = index <= highestUnlockedLevel
                        
                        Button("\(index)") {
                            router.route = .game(level: index)
                        }
                        .buttonStyle(SubButtonStyle(imageName: "small_button"))
                                        .disabled(!unlocked)                 // блокуємо тап
                                        .saturation(unlocked ? 1 : 0)       // «сірим» для закритих
                    }
                }
                
                Spacer()
                
            }
        }
        .onAppear {
            UserDefaults.standard.set(true, forKey: "level_1")
        }
    }
}

#Preview {
    LevelsView()
}
