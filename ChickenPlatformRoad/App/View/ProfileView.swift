//
//  ProfileView.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 04/11/25.


import SwiftUI

struct ProfileView: View {
    @StateObject private var vm = ProfileViewModel()
    @EnvironmentObject private var router: AppRouter
    
    @State private var showAvatarPicker = false
    
    var body: some View {
        ZStack {
            Image("bg_loading")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    
                    Button("") {
                        router.route = .menu
                    }
                    .buttonStyle(SubButtonStyle(imageName: "back"))
                    
                    Spacer()
                    
                    
                }
                .padding(.horizontal, 20)
                .padding(.bottom, screenHeight * 0.02)
                
                VStack(spacing: 40) {
                    Text("PROFILE")
                        .customFont(size: titleFontSize)
                        .padding()
                    
                    Button(action: {
                        withAnimation {
                            showAvatarPicker = true
                        }
                    }) {
                        ZStack {
                            Image("small_button")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth * 0.33)
                            
                            
                            Image(vm.selectedAvatar.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth * 0.23)
                        }
                        .overlay {
                            Image(systemName: "square.and.pencil")
                                .font(.callout)
                                .bold()
                                .foregroundStyle(.white)
                                .padding(5)
                                .background(Color.green)
                                .cornerRadius(5)
                                .padding(.top, screenHeight * 0.15)
                        }
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 10) {
                        TextField("Your name", text: $vm.name)
                            .textInputAutocapitalization(.words)
                            .disableAutocorrection(true)
                            .customFont(size: 20)
                        
                        Image(systemName: "square.and.pencil")
                            .customFont(size: 15)
                    }
                    .padding(.horizontal)
                    .frame(height: screenHeight * 0.053)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.purpleRectStroke)
                    )
                    Spacer()
                }
                .padding(30)
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
                .padding(.horizontal, 55)
                
                Spacer()
                
                Button("SAVE") {
                    vm.save()
                }
                .buttonStyle(MainButtonStyle(isBig: true))
            }
            if showAvatarPicker {
                Color.black.opacity(0.7).ignoresSafeArea()
                    .zIndex(0)
                
                AvatarPickerView(selected: $vm.selectedAvatar, showAvatarPicker: $showAvatarPicker)
                    .transition(.asymmetric(
                        insertion: .move(edge: .bottom).combined(with: .opacity),
                        removal: .move(edge: .bottom).combined(with: .opacity)
                    ))
                    .zIndex(1)
            }
        }
    }
}

#Preview {
    ProfileView()
}
