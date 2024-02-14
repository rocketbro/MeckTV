import SwiftUI

struct SplashScreen: View {
    @State private var showingSeal = false
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            LinearGradient(colors: [MeckColor().primary(.teal), MeckColor().primary(.teal).opacity(0.55)], startPoint: .bottomLeading, endPoint: .topTrailing)
                .ignoresSafeArea()
            
            GeometryReader { geo in
                    Image("White seal")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.height * 0.35)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .opacity(showingSeal ? 1 : 0)
            }
            
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation {
                    showingSeal.toggle()
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
