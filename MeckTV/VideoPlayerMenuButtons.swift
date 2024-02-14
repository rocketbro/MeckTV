//
//  VideoPlayerMenuButtons.swift
//  MeckTV
//
//  Created by Asher Pope on 2/24/23.
//

import SwiftUI
import AVKit

struct PlayPauseButton: View {
    let player: AVPlayer
    @ObservedObject var menuVC: MenuVisibiltyController
    
    var body: some View {
        // Play/pause button
        Image(systemName: menuVC.playPauseButtonIcon.rawValue)
            .foregroundColor(.white)
            .font(.largeTitle)
            .frame(width: 50, height: 50)
            .frame(width: 50, height: 50)
            .contentShape(Rectangle())
            .highPriorityGesture(
                TapGesture()
                    .onEnded {
                        if menuVC.isPlaying {
                            player.pause()
                            menuVC.playPauseButtonIcon = .play
                            menuVC.isPlaying = false
                        } else {
                            player.play()
                            menuVC.playPauseButtonIcon = .pause
                            menuVC.isPlaying = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                if menuVC.isPlaying && menuVC.showingMenu {
                                    withAnimation {
                                        menuVC.showingMenu.toggle()
                                    }
                                }
                            }
                        }
                    })
    }
}

struct FullscreenButton: View {
    @ObservedObject var menuVC: MenuVisibiltyController
    
    var body: some View {
        Image(systemName: menuVC.fullscreenButtonIcon.rawValue)
            //.rotationEffect(Angle(degrees: 90))
            .foregroundColor(.white)
            .font(.title3)
            .frame(width: 30, height: 30)
            .frame(width: 30, height: 30)
            .contentShape(Rectangle())
            .highPriorityGesture(
                TapGesture()
                    .onEnded {
                        if menuVC.showingFullscreen {
                            menuVC.showingFullscreen = false
                            menuVC.fullscreenButtonIcon = .expand
                            menuVC.dismissingMenuIn = 3
                        } else {
                            menuVC.showingFullscreen = true
                            menuVC.fullscreenButtonIcon = .shrink
                            menuVC.dismissingMenuIn = 3
                        }
                    })
    }
    
}

struct MuteButton: View {
    let player: AVPlayer
    @ObservedObject var menuVC: MenuVisibiltyController
    
    var body: some View {
        Image(systemName: menuVC.muteButtonIcon.rawValue)
            .foregroundColor(.white)
            .font(.title3)
            .frame(width: 30, height: 30)
            .frame(width: 30, height: 30)
            .contentShape(Rectangle())
            .highPriorityGesture(
                TapGesture()
                    .onEnded {
                        if player.volume != 0.0 {
                            menuVC.playerVolume = 0.0
                            player.volume = menuVC.playerVolume
                            menuVC.muteButtonIcon = .muted
                        } else {
                            menuVC.playerVolume = 0.5
                            player.volume = menuVC.playerVolume
                            menuVC.muteButtonIcon = .unmuted
                        }
                    })
    }
}
