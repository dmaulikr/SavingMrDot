//
//  RDRVideoController.swift
//  RunDotRun
//
//  Created by Haoruo Peng on 1/9/16.
//  Copyright © 2016 Haoruo Peng. All rights reserved.
//

import Foundation

import UIKit
import AVKit
import SpriteKit
import MediaPlayer

class RDRVideoController: UIViewController {
    var soundEffects = [String: RDRAudioPlayer]()
    var player = AVPlayer()
    
    func playVideo() {
        let url = NSBundle.mainBundle().URLForResource("GAME_OPENER", withExtension: "mp4")
        let item = AVPlayerItem(URL: url!)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerDidFinishPlaying:", name: AVPlayerItemDidPlayToEndTimeNotification, object: item)
        player = AVPlayer(playerItem: item)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
        
        let button_skip = UIButton(type: UIButtonType.System) as UIButton
        
        var h = CGFloat(10)
        if (self.view.bounds.height > self.view.bounds.width) {
            h = CGFloat(310)
        }
        
        button_skip.frame = CGRectMake(self.view.frame.width-50, h, 32, 32)
        button_skip.setBackgroundImage(UIImage(named: "SKIP"), forState: UIControlState.Normal)
        button_skip.layer.cornerRadius = 0.5 * button_skip.bounds.size.width
        button_skip.addTarget(self, action: "buttonTransit:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button_skip)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playVideo()
    }
    
    func playerDidFinishPlaying(note: NSNotification) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("TitleMenu") as! RDRTitleViewController
        self.presentViewController(nextViewController, animated:true, completion:nil)
    }
    
    func buttonTransit(sender: UIButton!) {
        player.pause()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("TitleMenu") as! RDRTitleViewController
        self.presentViewController(nextViewController, animated:false, completion:nil)
        playSoundEffect("BUTTON_PRESS_3") // BUTTON_PRESS_1, BUTTON_PRESS_2
    }
    
    func playSoundEffect(key: String) {
        var player: RDRAudioPlayer
        if (soundEffects.keys.contains(key)) {
            player = soundEffects[key]!
        } else {
            player = RDRAudioPlayer(filename: key, num: 0)
            player.setVolume(constants.soundVolume)
            soundEffects[key] = player
        }
        player.playMusic()
    }
    
    func stopSoundEffect(key: String) {
        if (soundEffects.keys.contains(key)) {
            let player = soundEffects[key]!
            player.stopMusic()
        }
    }
    
    func stopAllSoundEffect() {
        for player in soundEffects.values {
            player.stopMusic()
        }
    }
}