//
//  MenuVisibilityController.swift
//  MeckTV
//
//  Created by Asher Pope on 2/24/23.
//

import SwiftUI

class MenuVisibiltyController: ObservableObject {
    @Published var isPlaying = false
    @Published var showingMenu = false
    @Published var dismissingMenuIn = 0
    @Published var showingFullscreen = false
    
    enum PlayPauseIcon: String {
        case play = "play.fill"
        case pause = "pause.fill"
    }
    @Published var playPauseButtonIcon: PlayPauseIcon = .pause
    
    enum FullscreenIcon: String {
        case shrink = "arrow.down.right.and.arrow.up.left"
        case expand = "arrow.up.left.and.arrow.down.right"
    }
    @Published var fullscreenButtonIcon: FullscreenIcon = .expand
    
    
    enum MuteIcon: String {
        case muted = "speaker.slash.fill"
        case unmuted = "speaker.wave.2.fill"
    }
    
    // Set intial player volume
    @Published var muteButtonIcon: MuteIcon = .unmuted
    @Published var playerVolume: Float = 0.5
    
}
