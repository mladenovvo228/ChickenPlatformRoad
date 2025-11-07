//
//  ContentView.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 03/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var progress: Double = 0.0
    @StateObject private var router = AppRouter()
    @StateObject private var shopVM = ShopViewModel.shared

    var body: some View {
        ZStack {
            switch router.route {
            case .loading:
                LoadingView(progress: $progress)
                    .transition(.opacity)
                    .id(AppRoute.loading)
            case .main:
                MainView()
                    .transition(.opacity)
                    .id(AppRoute.main)
            case .info:
                InfoView()
                    .transition(.opacity)
                    .id(AppRoute.info)
            case .menu:
                MenuView()
                    .transition(.opacity)
                    .id(AppRoute.menu)
            case .profile:
                ProfileView()
                    .transition(.opacity)
                    .id(AppRoute.profile)
            case .settings:
                SettingsView()
                    .transition(.opacity)
                    .id(AppRoute.settings)
            case .levels:
                LevelsView()
                    .transition(.opacity)
                    .id(AppRoute.levels)
            case .leaderboard:
                LeaderboardsView()
                    .transition(.opacity)
                    .id(AppRoute.leaderboard)
            case .shop:
                ShopView()
                    .transition(.opacity)
                    .id(AppRoute.shop)
            case .game(level: let level):
                GameView(level: level)
                    .transition(.opacity)
                    .id(AppRoute.game(level: level))
            }
            

        }
        .animation(.easeInOut(duration: 0.8), value: router.route)
        .environmentObject(router)
        .environmentObject(shopVM)
    }
}



#Preview {
    ContentView()
}
