import SwiftUI

struct LoadingView: View {
    @Binding var progress: Double
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            Image("bg_loading")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer(minLength: 120)
                
                Image("chicken1")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .overlay(alignment: .bottom) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.white)
                                .shadow(color: .black.opacity(0.08), radius: 6, y: 2)
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(LinearGradient(colors: [.red, .yellow], startPoint: .top, endPoint: .bottom), lineWidth: 3)
                                )
                            
                            
                            GeometryReader { geo in
                                let width = geo.size.width * progress
                                RoundedRectangle(cornerRadius: 15)                                    .fill(LinearGradient(colors: [.red, .yellow],
                                                         startPoint: .leading, endPoint: .trailing))
                                    .frame(width: width, height: 50)
                                    .animation(.spring(response: 0.5, dampingFraction: 0.85), value: progress)
                            }
                            .frame(height: 50)
                            
                            Text("\(Int(progress * 100))%")
                                .customFont(size: 22)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 12)
                    }
            }
        }
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { t in
                progress += 0.008
                if progress >= 1.0 {
                    progress = 1.0
                    t.invalidate()
                }
            }
        }
        .onDisappear { timer?.invalidate() }
    }
}
