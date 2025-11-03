//
//  ContentView.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 03/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var progress: Double = 0.0
    @State private var showMain = false

    var body: some View {
        ZStack {
            if showMain {
                MainView()
                    .transition(.opacity)
            } else {
                LoadingView(progress: $progress)
            }
        }
        .animation(.easeInOut(duration: 0.8), value: showMain)
        .onChange(of: progress) { newValue in
            if newValue >= 1.0 {
                withAnimation {
                    showMain = true
                }
            }
        }
    }
}



#Preview {
    ContentView()
}
