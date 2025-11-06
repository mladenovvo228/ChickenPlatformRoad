//
//  ShopViewModel.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 06/11/25.
//

import SwiftUI

class ShopViewModel: ObservableObject {
    static let shared = ShopViewModel()
    
    private let coinsKey = "coins"
    private let ownedKey = "owned_skins"
    private let selectedKey = "selected_skin"
    
    @Published var totalCoins: Int = 0 {
        didSet { fetchCoins() }
    }
    @Published var skins: [Skin] = []
    @Published var owned: Set<String> = []
    @Published var selectedSkin: String = ""
    @Published var message: String? = nil
    @Published var showNoMoneyAlert: Bool = false
    
    private let catalog: [Skin] = [
        .init(id: "egg1", name: "Base Egg", price: 0),
        .init(id: "egg2", name: "Red Egg", price: 150),
        .init(id: "egg3", name: "Frosty Egg", price: 300),
        .init(id: "egg4", name: "Star Egg", price: 450),
        .init(id: "egg5", name: "Fire Egg", price: 600),
        .init(id: "egg6", name: "Meteor Egg", price: 750)
    ]
    
    init() {
        load()
    }
    
    func load() {
        let storage = UserDefaults.standard
        
        if storage.object(forKey: coinsKey) == nil {
            totalCoins = 1000
            storage.set(totalCoins, forKey: coinsKey)
        } else {
            totalCoins = storage.integer(forKey: coinsKey)
        }
        
        if let data = storage.data(forKey: ownedKey),
           let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
            owned = decoded
        } else {
            owned = ["egg1"]
            fetchOwned()
        }
        
        if let sel = storage.string(forKey: selectedKey) {
            selectedSkin = sel
        } else {
            selectedSkin = "egg1"
            storage.set(selectedSkin, forKey: selectedKey)
        }
        
        skins = catalog
    }
    
    func fetchOwned() {
        let ud = UserDefaults.standard
        if let data = try? JSONEncoder().encode(owned) {
            ud.set(data, forKey: ownedKey)
        }
    }
    
    func fetchCoins() {
        UserDefaults.standard.set(totalCoins, forKey: coinsKey)
    }
    
    func fetchSelectedSkin() {
        UserDefaults.standard.set(selectedSkin, forKey: selectedKey)
    }
    
    func isOwned(_ skin: Skin) -> Bool {
        owned.contains(skin.id)
    }
    
    func isSelected(_ skin: Skin) -> Bool {
        selectedSkin == skin.id
    }
    
    func buy(_ skin: Skin) {
        guard !isOwned(skin) else {
            message = "Already owned"
            return
        }
        guard totalCoins >= skin.price else {
            showNoMoneyAlert = true
            return
        }
        totalCoins -= skin.price
        fetchCoins()
        
        owned.insert(skin.id)
        fetchOwned()
        
        message = "Purchased \(skin.name)"
    }
    
    func equip(_ skin: Skin) {
        guard isOwned(skin) else {
            message = "You don't own this skin"
            return
        }
        selectedSkin = skin.id
        fetchSelectedSkin()
        message = "\(skin.name) selected"
    }
}
