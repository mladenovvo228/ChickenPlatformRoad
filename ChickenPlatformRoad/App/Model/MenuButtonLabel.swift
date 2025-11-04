//
//  MenuButtonLabel.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 03/11/25.
//

import Foundation
import SwiftUI

enum MenuButtonLabel: String, CaseIterable {
    case profile = "Profile"
    case shop = "Shop"
    case settings = "Settings"
    case leaderboard = "Leaderboard"
    case exit = "Exit"
    

    func perform(router: AppRouter) {
        switch self {
        case .profile:
            withAnimation {
                router.route = .profile
            }
        case .settings:
            withAnimation {
                router.route = .settings
            }
        case .leaderboard:
            withAnimation {
                router.route = .leaderboard
            }
        case .shop:
            withAnimation {
                router.route = .shop
            }
        case .exit:
            withAnimation {
                Darwin.exit(0)
            }
        }
    }
}
