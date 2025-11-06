//
//  SkinCard.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 06/11/25.
//

import SwiftUI

struct SkinCard: View {
    @EnvironmentObject private var vm: ShopViewModel
    
    let skin: Skin
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Image(skin.id)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight * 0.2)
                    .shadow(color: .yellow.opacity(vm.isSelected(skin) ? 0.45 : 0.0), radius: 18, y: 6)
            }

            Text(skin.name)
                .customFont(size: screenHeight * 0.025)

            if vm.isOwned(skin) {
                Text("Owned")
                    .customFont(size: screenHeight * 0.02, color: .green)
            } else {
                HStack(spacing: 6) {
                    Image("coin")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenWidth * 0.07)
                    Text("\(skin.price)")
                        .customFont(size: screenHeight * 0.02)
                }
            }

            if vm.isOwned(skin) {
                Button(vm.selectedSkin == skin.id ? "Selected" : "Select") {
                    vm.equip(skin)
                }
                .buttonStyle(MainButtonStyle(isBig: false))
                .disabled(vm.isSelected(skin))
                
            } else {
                Button("Buy") {
                    vm.buy(skin)
                }
                .buttonStyle(MainButtonStyle(isBig: false))
            }
        }
        .frame(maxWidth: screenWidth * 0.9, maxHeight: screenHeight * 0.6)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.purpleRect)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.purpleRectStroke, lineWidth: 3)
                )
                .opacity(0.8)
        )
    }
}
