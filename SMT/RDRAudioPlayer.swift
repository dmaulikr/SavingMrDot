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
    
    init(filename: String, num: Int) {
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
        
        player.numberOfLoops = num
        player.prepareToPlay()
    }
    
    func setVolume(vol: Float) {
        player.volume = vol
    }
    
    func playMusic() {
        if (!player.playing) {
            player.play()
        }
    }
    
    func pauseMusic() {
        if (player.playing) {
            player.pause()
        }
    }
    
    func stopMusic() {
        if (player.playing) {
            player.stop()
        }
    }
}
