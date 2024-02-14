//
//  MeckTVPlayer.swift
//  MeckTV
//
//  Created by Asher Pope on 2/20/23.
//

import SwiftUI
import AVKit

struct MeckTVPlayer: View {
    let player: AVPlayer
    @ObservedObject var menuVC: MenuVisibiltyController
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
   
    var body: some View {
        ZStack {
            ZStack {
                
                // The video layer
                CustomVideoPlayer(player: player)
                    .onAppear {
                        player.volume = menuVC.playerVolume
                        player.play()
                        menuVC.isPlaying = true
                        menuVC.playPauseButtonIcon = .pause
                    }.ignoresSafeArea()
                
                
                // The "LIVE" bug
                GeometryReader { geo in
                    Text("LIVE")
                        .foregroundColor(.white)
                        .font(.caption)
                        .bold()
                        .padding(.horizontal, 3)
                        .padding(.vertical, 1)
                        .background(.red)
                        .cornerRadius(4)
                        .padding(.leading)
                        .padding(.top)
                }
                .aspectRatio(16/9, contentMode: .fit)
            }
            .zIndex(1)
            
            // Conditionally show the menu
            if menuVC.showingMenu {
                VStack {
                    VideoPlayerMenu(player: player, menuVC: menuVC)
                }
                .zIndex(2)
                .onReceive(timer) { _ in
                    print("Dismissing menu in \(menuVC.dismissingMenuIn)")
                    if menuVC.dismissingMenuIn > 1 {
                        menuVC.dismissingMenuIn -= 1
                    } else {
                        withAnimation {
                            menuVC.showingMenu.toggle()
                            print("Menu dismissed.")
                        }
                        timer.upstream.connect().cancel()
                        print("Menu dismissal timer stopped.")
                    }
                }
            }
            
        } // End of root ZStack scope
        .contentShape(Rectangle())
        .onTapGesture {
            print("Canceling menu dismissal timer (if present).")
            timer.upstream.connect().cancel()
            menuVC.dismissingMenuIn = 3
            withAnimation {
                menuVC.showingMenu.toggle()
            }
        }
        
    }

}


class PlayerView: UIView {
    
    // Override the property to make AVPlayerLayer the view's backing layer.
    override static var layerClass: AnyClass { AVPlayerLayer.self }
    
    // The associated player object.
    var player: AVPlayer? {
        get { playerLayer.player }
        set { playerLayer.player = newValue }
    }
    
    private var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
}

struct CustomVideoPlayer: UIViewRepresentable {
    let player: AVPlayer
    
    func makeUIView(context: Context) -> PlayerView {
        let view = PlayerView()
        view.player = player
        return view
    }
    
    func updateUIView(_ uiView: PlayerView, context: Context) { }
}
