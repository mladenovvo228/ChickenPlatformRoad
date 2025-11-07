//
//  LeaderboardViewModel.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 07/11/25.
//

import SwiftUI

class LeaderboardViewModel: ObservableObject {
    @Published var rows: [LeaderboardModel] = []
    
    func reload() {
        let newRows = LeaderboardManager.shared.getSortedPlayers()
        guard newRows != rows else { return }
        DispatchQueue.main.async { [weak self] in
            self?.rows = newRows
        }
    }
}
