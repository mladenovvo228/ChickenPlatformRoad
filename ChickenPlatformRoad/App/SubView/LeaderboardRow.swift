//
//  LeaderboardRow.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 07/11/25.
//

import SwiftUI

struct LeaderboardRow: View {
    let entry: LeaderboardModel

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.purpleRectStroke)
                .overlay(
                    HStack {
                        Spacer()
                            .frame(width: screenWidth * 0.15)
                        
                        Text(entry.name.uppercased())
                            .customFont(size: 20)
                            .lineLimit(1)
                        Spacer()
                        
                        Text("\(entry.bestLevel)")
                            .customFont(size: 20)
                    }
                    .padding(.horizontal)
                )
        }
        .frame(height: screenHeight * 0.07)
        .overlay(alignment: .leading) {
            ZStack {
                Image("small_button")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight * 0.09)

                Image(entry.avatar)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight * 0.06)
            }
            .offset(x: -14)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, screenHeight * 0.01)
    }
}
