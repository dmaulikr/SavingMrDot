//
//  RDRTitleViewController.swift
//  RunDotRun
//
//  Created by Haoruo Peng on 1/15/16.
//  Copyright © 2016 Haoruo Peng. All rights reserved.
//

import UIKit
import SpriteKit

class RDRTitleViewController: UIViewController {
    var soundEffects = [String: RDRAudioPlayer]()
    let musicPlayer = RDRAudioPlayer(filename: "MUSIC", num: -1)
    
    func addBackground() {
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let background = UIImageView(frame: CGRectMake(0, 0, width, height))
        background.image = UIImage(named: "TITLE_SCREEN_FARM")
        background.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(background)
        self.view.sendSubviewToBack(background)
        
        let cloud = UIImageView(frame: CGRectMake(-800, 0, width, height))
        cloud.image = UIImage(named: "TITLE_SCREEN_CLOUDS")
        cloud.contentMode = UIViewContentMode.ScaleAspectFill
        cloud.tag = 1
        self.view.addSubview(cloud)
        
        let optionImg = UIImageView(frame: CGRectMake(0, 0, width, height))
        optionImg.image = UIImage(named: "TITLE_SCREEN_BUTTON_OPTIONS_NORMAL")
        optionImg.contentMode = UIViewContentMode.ScaleAspectFill
        optionImg.tag = 2
        self.view.addSubview(optionImg)
        
        let button_opt   = UIButton(type: UIButtonType.System) as UIButton
        button_opt.frame = CGRectMake(400, 125, 66, 60)
        button_opt.backgroundColor = UIColor.clearColor()
        button_opt.layer.cornerRadius = 0.5 * button_opt.bounds.size.width
        button_opt.addTarget(self, action: "buttonTransitOPT:", forControlEvents: UIControlEvents.TouchUpInside)
        button_opt.addTarget(self, action: "buttonActivateOPT:", forControlEvents: UIControlEvents.TouchDown)
        button_opt.addTarget(self, action: "buttonDeactivateOPT:", forControlEvents: UIControlEvents.TouchUpOutside)
        self.view.addSubview(button_opt)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackground()
        print(musicPlayer.player.playing)
        if (!musicPlayer.player.playing) {
            musicPlayer.setVolume(constants.musicVolume)
            musicPlayer.playMusic()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        moveImage(view.viewWithTag(1) as! UIImageView)
        //if (musicPlayer.player.playing) {
            //musicPlayer.setVolume(constants.musicVolume)
            //musicPlayer.playMusic()
        //}
    }

    func moveImage(view: UIImageView){
        let toPoint: CGPoint = CGPointMake(1600.0, 0.0)
        let fromPoint : CGPoint = CGPointMake(0.0, 0.0)
        
        let movement = CABasicAnimation(keyPath: "position")
        movement.additive = true
        movement.fromValue =  NSValue(CGPoint: fromPoint)
        movement.toValue =  NSValue(CGPoint: toPoint)
        movement.repeatCount = Float.infinity
        movement.duration = 20
        view.layer.addAnimation(movement, forKey: "move")
    }
    
    func buttonTransitOPT(sender: UIButton!) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("optionMenu") as! RDROptionViewController
        self.presentViewController(nextViewController, animated:true, completion:nil)
    }
    
    func buttonActivateOPT(sender: UIButton!) {
        let optionImg = view.viewWithTag(2) as! UIImageView
        optionImg.image = UIImage(named: "TITLE_SCREEN_BUTTON_OPTIONS_ACTIVATED")
        playSoundEffect("BUTTON_PRESS_3") // BUTTON_PRESS_1, BUTTON_PRESS_2
    }
    
    func buttonDeactivateOPT(sender: UIButton!) {
        let optionImg = view.viewWithTag(2) as! UIImageView
        optionImg.image = UIImage(named: "TITLE_SCREEN_BUTTON_OPTIONS_NORMAL")
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
