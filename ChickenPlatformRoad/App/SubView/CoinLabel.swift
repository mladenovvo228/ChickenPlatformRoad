//
//  CoinLabel.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 03/11/25.
//

import SwiftUI

struct CoinLabel: View {
    var coins: Int
    
    var body: some View {
        HStack(spacing: screenWidth * -0.1) {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.orange)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.red, lineWidth: 3)
                )
                .frame(width: screenWidth * 0.25, height: screenHeight * 0.04)

            
            Image("coin")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight * 0.075)

        }
        .overlay(
            Text("\(coins)")
                .customFont(size: screenHeight * 0.025)
                .padding(.trailing, screenWidth * 0.15)
        )
    }
}


#Preview {
    CoinLabel(coins: 2)
}
