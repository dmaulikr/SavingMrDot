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
    func playVideo() {
        let url = NSBundle.mainBundle().URLForResource("GAME_OPENER", withExtension: "mp4")
        let item = AVPlayerItem(URL: url!)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerDidFinishPlaying:", name: AVPlayerItemDidPlayToEndTimeNotification, object: item)
        let player = AVPlayer(playerItem: item)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
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
}