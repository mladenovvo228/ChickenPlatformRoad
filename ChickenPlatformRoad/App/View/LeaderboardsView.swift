//
//  LeaderboardsView.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 06/11/25.
//

import SwiftUI

struct LeaderboardsView: View {
    @EnvironmentObject private var router: AppRouter
    @StateObject private var vm = LeaderboardViewModel()
    
    var body: some View {
        ZStack {
            Image("bg_loading")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button("") { router.route = .menu }
                        .buttonStyle(SubButtonStyle(imageName: "back"))
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, screenHeight * 0.01)
                
                VStack(spacing: 12) {
                    Text("LEADERBOARD")
                        .customFont(size: titleFontSize)
                        .padding(.top, 10)
                    
                    ScrollView {
                        VStack {
                            ForEach(vm.rows) { row in
                                LeaderboardRow(entry: row)
                            }
                        }
                        .padding(.horizontal, 12)
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.purpleRect.opacity(0.85))
                        .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.purpleRectStroke, lineWidth: 3))
                )
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 30)
                .onAppear {
                    vm.reload()
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    LeaderboardsView()
}
