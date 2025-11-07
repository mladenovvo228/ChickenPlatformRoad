//
//  LeaderboardModel.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 07/11/25.
//

import Foundation

struct LeaderboardModel: Codable, Identifiable, Equatable {
    var name: String
    var avatar: String
    var bestLevel: Int
    
    var id: String { name.lowercased() }
}
