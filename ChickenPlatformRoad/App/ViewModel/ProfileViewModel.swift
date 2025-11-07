//
//  ProfileViewModel.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 04/11/25.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var selectedAvatar: Avatar = .chick1
    
    let avatars = Avatar.allCases
    private let nameKey = "nameKey"
    private let avatarKey = "avatarKey"
    private let levelsKey = "highestUnlockedLevel"
    
    private let storage = UserDefaults.standard
    private var originalName: String = "Guest"
    
    init() {
        load()
    }
    
    func load() {
        if let saved = storage.string(forKey: nameKey), !saved.isEmpty {
            name = saved
            originalName = saved
        } else {
            name = "Guest"
        }
        if let raw = storage.string(forKey: avatarKey),
           let av = Avatar(rawValue: raw) {
            selectedAvatar = av
        } else {
            selectedAvatar = .chick1
        }
        
        LeaderboardManager.shared.addOrUpdatePlayer(name: name, avatar: selectedAvatar.imageName)
    }
    
    var hasChanges: Bool {
        let savedName = storage.string(forKey: nameKey) ?? "Guest"
        return savedName != name
    }
    
    func save() {
        let cleaned = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let finalName = cleaned.isEmpty ? "Guest" : cleaned
        
        storage.set(finalName, forKey: nameKey)
        storage.set(selectedAvatar.imageName, forKey: avatarKey)

        if finalName.lowercased() != originalName.lowercased() {
            LeaderboardManager.shared.addOrUpdatePlayer(name: finalName, avatar: selectedAvatar.imageName)
            originalName = finalName
            storage.set(1, forKey: "highestUnlockedLevel")
        } else {
            LeaderboardManager.shared.updateAvatar(name: finalName, avatar: selectedAvatar.imageName)
        }
    }
    
}
