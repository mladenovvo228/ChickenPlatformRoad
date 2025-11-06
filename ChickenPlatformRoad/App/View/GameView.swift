//
//  GameView.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 05/11/25.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    @EnvironmentObject private var router: AppRouter
    @StateObject private var vm: GameViewModel
    @EnvironmentObject private var shopVM: ShopViewModel
    
    init(level: Int) {
        _vm = StateObject(wrappedValue: GameViewModel(level: level))
    }
    
    var body: some View {
        ZStack {
            SpriteView(scene: vm.scene, debugOptions: [.showsPhysics, .showsNodeCount])
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        vm.pause.toggle()
                        vm.scene.isPaused.toggle()
                    }) {
                        Image("back-1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth * 0.18)
                        
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    CoinLabel(coins: shopVM.totalCoins)
                        .scaleEffect(0.8)
                    
                    HStack {
                        Text("\(vm.score)/\(vm.toScore)")
                            .customFont(size: 35, color: .white)
                    }
                    .padding()
                    
                    
                }
                .offset(y: -20)
                Spacer()
            }
            
            if vm.pause {
                VStack(spacing: 30) {
                    Spacer()
                    
                    Text("Paused")
                        .customFont(size: 50, color: .white)
                    
                    HStack {
                        Button("home") {
                            router.route = .levels
                        }
                        .buttonStyle(GameMenuButtonStyle())
                        
                        Spacer()
                        
                        Button("restart") {
                            vm.resetScene(new: false)
                        }
                        .buttonStyle(GameMenuButtonStyle())
                    }
                    .padding(.horizontal, screenWidth * 0.15)
                    
                    Spacer()
                    
                    Button("Play") {
                        vm.pause.toggle()
                        Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { _ in
                            vm.scene.isPaused.toggle()
                            vm.scene.label.removeFromParent()
                            
                        }
                        vm.scene.start()
                    }
                    .buttonStyle(MainButtonStyle(isBig: true))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.ignoresSafeArea().opacity(0.65))
            }
            
            if vm.failed {
                VStack(spacing: 30) {
                    Spacer()
                    
                    Text("you lose!")
                        .customFont(size: 50, color: .white)
                    
                    HStack {
                        Button("home") {
                            router.route = .levels
                        }
                        .buttonStyle(GameMenuButtonStyle())
                        
                    }
                    .padding(.horizontal, screenWidth * 0.15)
                    
                    Spacer()
                    
                    Button("try\nagain") {
                        vm.resetScene(new: false)
                    }
                    .buttonStyle(MainButtonStyle(isBig: true, isSmallerFont: true))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.ignoresSafeArea().opacity(0.65))
            }
            
            if vm.completed {
                VStack(spacing: 30) {
                    Spacer()
                    
                    Text("you win")
                        .customFont(size: 50, color: .white)
                    
                    HStack {
                        Button("home") {
                            router.route = .levels
                        }
                        .buttonStyle(GameMenuButtonStyle())
                        
                        Spacer()
                        
                        Button("restart") {
                            vm.resetScene(new: false)
                        }
                        .buttonStyle(GameMenuButtonStyle())
                    }
                    .padding(.horizontal, screenWidth * 0.15)
                    
                    Spacer()
                    
                    Button("next") {
                        vm.resetScene(new: true)
                    }
                    .buttonStyle(MainButtonStyle(isBig: true))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.ignoresSafeArea().opacity(0.65))
            }
        }
    }
}

#Preview {
    GameView(level: 1)
}
