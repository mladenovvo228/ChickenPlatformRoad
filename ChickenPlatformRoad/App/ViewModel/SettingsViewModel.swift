//
//  SettingsViewModel.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 04/11/25.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var isSoundOn: Bool = true
    @Published var isVibrationOn: Bool = true
    @Published var isNotificationOn: Bool = true
    
    private let soundKey = "soundKey"
    private let vibroKey = "vibroKey"
    private let notifKey = "notifKey"
    private let storage = UserDefaults.standard
    
    init() {
        load()
    }
    
    func load() {
        if storage.object(forKey: soundKey) != nil {
            isSoundOn = storage.bool(forKey: soundKey)
        }
        
        if storage.object(forKey: vibroKey) != nil {
            isVibrationOn = storage.bool(forKey: vibroKey)
        }
        
        if storage.object(forKey: notifKey) != nil {
            isNotificationOn = storage.bool(forKey: notifKey)
        }
    }
    
    func save() {
        storage.set(isSoundOn, forKey: soundKey)
        storage.set(isVibrationOn, forKey: vibroKey)
        storage.set(isNotificationOn, forKey: notifKey)
    }
}
