//
//  AppState.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 03/11/25.
//

import Foundation

enum AppRoute: Equatable, Hashable {
    case loading
    case main
    case info
    case menu
    case profile
    case settings
    case levels
    case leaderboard
    case shop
    case game(level: Int)
}
