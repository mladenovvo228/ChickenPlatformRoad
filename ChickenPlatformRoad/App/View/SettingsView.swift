//
//  SettingsView.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 04/11/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var router: AppRouter
    @StateObject private var vm = SettingsViewModel()
    
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
                
                Spacer()
                
                VStack(spacing: 40) {
                    Text("Settings")
                        .customFont(size: titleFontSize)
                        .padding(.horizontal)
                    
                    VStack(spacing: 20) {
                        HStack {
                            Toggle("Sound", isOn: $vm.isSoundOn)
                        }
                        
                        HStack {
                            Toggle("Notification", isOn: $vm.isNotificationOn)
                        }
                        
                        HStack {
                            Toggle("Vibration", isOn: $vm.isVibrationOn)
                        }
                        
                    }
                    .customFont(size: 17)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                    
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
                .padding(.horizontal, 10)
                
                Spacer()
                
                Button("SAVE") {
                    vm.save()
                }
                .buttonStyle(MainButtonStyle(isBig: true))
            }
        }
    }
}

#Preview {
    SettingsView()
}
