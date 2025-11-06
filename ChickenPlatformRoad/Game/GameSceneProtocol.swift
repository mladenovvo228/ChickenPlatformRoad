//
//  GameSceneProtocol.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 06/11/25.
//

import Foundation

protocol GameSceneProtocol: AnyObject {
    func didUpdateScore(_ score: Int)
    func didCompleteLevel(_ level: Int)
    func didFailLevel()
    func selectedEgg() -> String
}
