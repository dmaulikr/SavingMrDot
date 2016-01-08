//
//  RDRAudioPlayer.swift
//  RunDotRun
//
//  Created by Haoruo Peng on 1/6/16.
//  Copyright © 2016 Haoruo Peng. All rights reserved.
//

import Foundation
import AVFoundation
import SpriteKit

class RDRAudioPlayer {
    var player: AVAudioPlayer!
    
    init(filename: String) {
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
        player.prepareToPlay()
    }
    
    func setVolume(vol: Float) {
        player.volume = vol
    }
    
    func playMusic() {
        player.play()
    }
    
    func pauseMusic() {
        player.pause()
    }
    
    func stopMusic() {
        player.stop()
        
        //SKAction.runBlock({self.player.play()})
    }
}
