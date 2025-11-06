//
//  GameViewModel.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 06/11/25.
//

import SwiftUI

class GameViewModel: ObservableObject, GameSceneProtocol {
    @Published var score = 0 {
        didSet {
            if score == toScore {
                scene.createFinish()
                scene.finish = true
                scene.platform.enumerateChildNodes(withName: "star") { child, _  in
                    child.removeFromParent()
                }
                
            }
        }
    }
    @Published var toScore = 0
    @Published var completed = false
    @Published var failed = false
    @Published var pause = false
    
    var level: Int
    let scene: GameScene
    private let shopVM = ShopViewModel.shared
    
    init(level: Int = 1) {
        self.level = level
        self.scene = GameScene(level: level)
        self.scene.gameProtocol = self
        self.toScore = 0
        self.toScore = 1 * level
    }
    
    func didUpdateScore(_ score: Int) {
        self.score = score
        if score >= toScore, !scene.finish {
            scene.finish = true
            scene.createFinish()
            scene.platform.enumerateChildNodes(withName: "star") { node, _ in node.removeFromParent() }
        }
    }
    
    func addCoin() {
        shopVM.totalCoins += 1
    }
    
    func didCompleteLevel(_ level: Int) {
        completed = true
        UserDefaults.standard.set(level + 1, forKey: "highestUnlockedLevel")
    }
    
    func didFailLevel() {
        failed = true
    }
    
    func resetScene(new: Bool) {
        if new {
            level += 1
            toScore = level * 1
        }
        pause = false
        completed = false
        failed = false
        score = 0
        scene.level = level
        scene.resetGame()
    }
    
    func selectedEgg() -> String {
        return UserDefaults.standard.string(forKey: "selected_skin") ?? "egg1"
    }
}
