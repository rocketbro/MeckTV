import SwiftUI
import AVKit

struct ContentView: View {
    @State private var showingSplash = true
    // Set up MeckTV stream player
    let player = AVPlayer(url: URL(string: "https://mecklenburg-admin.ravnur.com/channels/1-WRkqyx/master.m3u8")!)
    
    
    var body: some View {
        if showingSplash {
            SplashScreen()
                .onAppear {
                    do {
                        try AVAudioSession.sharedInstance().setCategory(.playback)
                    } catch {
                        print(error.localizedDescription)
                    }
                    player.play()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation {
                            showingSplash.toggle()
                        }
                    }
                }
        } else {
            Homepage(player: player)
        }
    }
}


struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.light)
    }
}
