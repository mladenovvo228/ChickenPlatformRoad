//
//  VibrationManager.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 05/11/25.
//

import UIKit

class VibrationManager {
    static func vibration() {
        if let vibration = UserDefaults.standard.value(forKey: "vibroKey") as? Bool, vibration {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
            feedbackGenerator.impactOccurred()
            print("ok")
        }
    }
}
