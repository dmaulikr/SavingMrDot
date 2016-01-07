//
//  RDRAudioPlayer.swift
//  RunDotRun
//
//  Created by Haoruo Peng on 1/6/16.
//  Copyright © 2016 Haoruo Peng. All rights reserved.
//

import Foundation
import AVFoundation

class RDRAudioPlayer {
    var player: AVAudioPlayer!
    
    func playMusic(filename: String) {
        let url = NSBundle.mainBundle().URLForResource("SOUNDS/" + filename, withExtension: "mp3")
        if (url == nil) {
            print("Can not find file")
        }
        
        do {
            player = try AVAudioPlayer(contentsOfURL: url!)
        } catch {
            print(error)
        }
        
        if (player == nil) {
            print("Can not create audio")
            return
        }
        
        player.numberOfLoops = -1
        player.volume = 0.1
        player.prepareToPlay()
        player.play()
    }
}
