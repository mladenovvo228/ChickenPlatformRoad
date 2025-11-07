//
//  LeaderboardManager.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 07/11/25.
//

import Foundation

class LeaderboardManager {
    static let shared = LeaderboardManager()
    private init() { loadFromStorage() }
    
    private let storageKey = "leaderboard_v1"
    private var players: [String: LeaderboardModel] = [:] { didSet { saveToStorage() } }
    
    
    func addOrUpdatePlayer(name: String, avatar: String) {
        let key = normalize(name)
        guard !key.isEmpty else { return }
        
        var player = players[key] ?? LeaderboardModel(name: name, avatar: avatar, bestLevel: 1)
        player.name = name
        player.avatar = avatar
        players[key] = player
    }
    
    func updateBestLevel(name: String, level: Int) {
        let key = normalize(name)
        guard !key.isEmpty else { return }
        
        var player = players[key] ?? LeaderboardModel(name: name, avatar: "avatar_chicken1", bestLevel: 1)
        if level > player.bestLevel { player.bestLevel = level }
        players[key] = player
    }
    
    func renamePlayer(from oldName: String, to newName: String) {
        let oldKey = normalize(oldName)
        let newKey = normalize(newName)
        
        guard let oldPlayer = players[oldKey] else {
            addOrUpdatePlayer(name: newName, avatar: "avatar_chicken1")
            return
        }
        
        var renamed = oldPlayer
        renamed.name = newName
        
        if let existing = players[newKey] {
            renamed.bestLevel = max(existing.bestLevel, oldPlayer.bestLevel)
            renamed.avatar = oldPlayer.avatar
        }
        
        players.removeValue(forKey: oldKey)
        players[newKey] = renamed
    }
    
    func updateAvatar(name: String, avatar: String) {
        let key = normalize(name)
        guard var player = players[key] else { return }
        player.avatar = avatar
        players[key] = player
    }
    
    func getSortedPlayers() -> [LeaderboardModel] {
        players.values.sorted {
            if $0.bestLevel != $1.bestLevel {
                return $0.bestLevel > $1.bestLevel
            } else {
                return $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            }
        }
    }
    
    private func saveToStorage() {
        guard let data = try? JSONEncoder().encode(players) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }
    
    private func loadFromStorage() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([String: LeaderboardModel].self, from: data)
        else { return }
        players = decoded
    }
    
    
    private func normalize(_ name: String) -> String {
        name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
}
