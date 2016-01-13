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
        let videoURL = NSURL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let player = AVPlayer(URL: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.presentViewController(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    func playVideo2(screen: SKView) {
        let videoURL = NSURL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let player = AVPlayer(URL: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
    }
}