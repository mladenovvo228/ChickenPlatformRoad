//
//  InfoView.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 03/11/25.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Image("bg_loading")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    
                    Button("") {
                        dismiss()
                    }
                    .buttonStyle(SubButtonStyle(imageName: "back"))
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, screenHeight * 0.07)
               
                
                VStack {
                    Text("How to play")
                        .customFont(size: 30)
                        .padding()
                    ScrollView {
                        Text("How to play")
                            .customFont(size: 30)
                            .padding()
                    }
                }
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.purpleRect)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.purpleRectStroke, lineWidth: 3)
                        )
                        .opacity(0.8)
                )
                .padding(.horizontal, 20)
                
            }
        }
    }
}

#Preview {
    InfoView()
}
