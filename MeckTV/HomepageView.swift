import SwiftUI
import AVKit

struct Homepage: View {
    let player: AVPlayer
    @StateObject var menuVC = MenuVisibiltyController()
    
    private let meckColor = MeckColor()
    
    var body: some View {
        ZStack {
            if menuVC.showingFullscreen {
                ZStack {
                    Color.black.ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                menuVC.showingMenu.toggle()
                            }
                        }
                    
                    MeckTVPlayer(player: player, menuVC: menuVC)
                    //.ignoresSafeArea()
                }
            } else {
                NavigationStack {
                    ZStack {
                        Color.white.ignoresSafeArea()
                        VStack(spacing: 15) {
                            VStack {
                                MeckTVPlayer(player: player, menuVC: menuVC)
                                    .aspectRatio(16/9, contentMode: .fit)
                                    .cornerRadius(10, antialiased: true)
                                    .onAppear {
                                        player.volume = 0.5
                                    }
                            }.padding(.bottom)
                            
                            Text("Now streaming 24/7 programming about County services, intiatives, and LIVE BOCC meeting coverage.")
                                .font(.custom("Merriweather-Regular", size: 16))
                                .foregroundColor(meckColor.primary(.darkGrey))
                            Spacer()
                        }
                        .navigationTitle("MeckTV")
                        .toolbarColorScheme(.dark, for: .navigationBar)
                        .toolbarBackground(meckColor.primary(.teal), for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .padding()
                        .background(.white)
                    }
                } // End of NavigationStack scope
            }
        }
    }
}


struct HomepageView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
