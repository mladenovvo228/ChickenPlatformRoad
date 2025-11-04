//
//  Avatar.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 04/11/25.
//

import Foundation

enum Avatar: String, CaseIterable, Identifiable {
    case chick1, chick2, chick3, chick4
    var id: String { rawValue }
    
    var imageName: String {
        switch self {
        case .chick1: return "avatar_chicken1"
        case .chick2: return "avatar_chicken2"
        case .chick3: return "avatar_chicken3"
        case .chick4: return "avatar_chicken4"
        }
    }
}
