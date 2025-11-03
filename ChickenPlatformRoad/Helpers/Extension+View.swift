//
//  Extension+View.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 03/11/25.
//

import SwiftUI

extension View {
    func customFont(size: CGFloat, color: Color = .white) -> some View {
        self.font(.custom("RubikMonoOne-Regular", size: size))
            .foregroundStyle(color)
            .shadow(color: .black, radius: 1, y: 1)
    }
    
    
}
