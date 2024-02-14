//
//  VideoPlayerMenu.swift
//  MeckTV
//
//  Created by Asher Pope on 2/24/23.
//

import SwiftUI
import AVKit

struct VideoPlayerMenu: View {
    let player: AVPlayer
    @ObservedObject var menuVC: MenuVisibiltyController
    
    var body: some View {
        
        ZStack {
            // Video overlay
            Color.black.opacity(0.25)
                .ignoresSafeArea()
            
            // Button layer
            VStack {
                
                Spacer()
                
                HStack {
                    MuteButton(player: player, menuVC: menuVC)
                    Spacer()
                    FullscreenButton(menuVC: menuVC)
                }
                
            }.padding()
            
            PlayPauseButton(player: player, menuVC: menuVC)
            
        }
        
    }
}
