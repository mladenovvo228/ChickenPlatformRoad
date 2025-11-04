//
//  AvatarPickerView.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 04/11/25.
//

import SwiftUI

struct AvatarPickerView: View {
    @Binding var selected: Avatar
    @Binding var showAvatarPicker: Bool
    
    private let columns = [GridItem(.adaptive(minimum: 80), spacing: 12)]
    
    var body: some View {
        VStack {
            
            Spacer()
            VStack(spacing: 16) {
                Text("PLEASE MAKE YOUR CHOICE")
                    .font(.system(size: 18, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.top, 30)
                
                Divider()
                    .background(Color.white.opacity(0.4))
                
                HStack {
                    ForEach(Avatar.allCases) { avatar in
                        Button {
                            selected = avatar
                        } label: {
                            ZStack {
                                Image(avatar.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 72)
                                    .padding(8)
                            }
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(.white.opacity(0.10))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(
                                        .white,
                                        lineWidth: selected == avatar ? 3 : 1
                                    )
                            )
                        }
                    }
                }
                .padding(.horizontal, 16)
                
                Button {
                    withAnimation {
                        showAvatarPicker = false
                    }
                } label: {
                    Text("CANCEL")
                        .font(.system(size: 16, weight: .heavy, design: .rounded))
                        .foregroundStyle(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
            }
            
            .padding(.bottom, 6)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.graySheet)
                    .ignoresSafeArea()
            )
        }
    }
}

