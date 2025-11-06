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
    
    init() {
        load()
    }
    
    func load() {
        if let saved = storage.string(forKey: nameKey), !saved.isEmpty {
            name = saved
        } else {
            name = "Guest"
        }
        if let raw = storage.string(forKey: avatarKey),
           let av = Avatar(rawValue: raw) {
            selectedAvatar = av
        } else {
            selectedAvatar = .chick1
        }
    }
    
    var hasChanges: Bool {
        let savedName = storage.string(forKey: nameKey) ?? "Guest"
        return savedName != name
    }
    
    func save() {
        if hasChanges {
            storage.set(1, forKey: levelsKey)
        }
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        storage.set(trimmed.isEmpty ? "Guest" : trimmed, forKey: nameKey)
        storage.set(selectedAvatar.rawValue, forKey: avatarKey)
    }
}
