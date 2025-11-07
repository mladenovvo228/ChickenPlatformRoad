//
//  ShopView.swift
//  ChickenPlatformRoad
//
//  Created by Dakota on 06/11/25.
//

import SwiftUI

struct ShopView: View {
    @EnvironmentObject private var router: AppRouter
    @StateObject private var vm = ShopViewModel()


    var body: some View {
        ZStack {
            Image("bg_loading")
                .resizable()
                .ignoresSafeArea()

            VStack {
                HStack(spacing: 12) {
                    Button("") { router.route = .menu }
                        .buttonStyle(SubButtonStyle(imageName: "back"))

                    Spacer()

                    CoinLabel(coins: vm.totalCoins)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 8)

                Text("SHOP")
                    .customFont(size: titleFontSize)
                    .padding(.bottom, 8)

                TabView {
                        ForEach(vm.skins) { skin in
                            SkinCard(skin: skin)
                                .environmentObject(vm)
                        }
                    
                }
                .tabViewStyle(.page)

                Spacer(minLength: 10)
            }

            if let message = vm.message {
                Text(message)
                    .customFont(size: 20)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .padding(.top, 18)
                    .frame(maxHeight: .infinity, alignment: .center)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                            withAnimation { self.vm.message = nil }
                        }
                    }
            }
        }
        .alert("Not enough coins", isPresented: $vm.showNoMoneyAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Earn more coins to buy this skin.")
        }
    }

}

#Preview {
    ShopView()
}
