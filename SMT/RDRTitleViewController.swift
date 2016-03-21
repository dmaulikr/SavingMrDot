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
    
    func addBackground() {
        var width = UIScreen.mainScreen().bounds.size.width
        var height = UIScreen.mainScreen().bounds.size.height
        
        var offset_x = CGFloat(0)
        var offset_y = CGFloat(0)
        if (height > width) {
            offset_x = width/2 - 667/2
            offset_y = height/2 - 375.1875/2
            width = 667
            height = 375.1875
        }
        
        let background = UIImageView(frame: CGRectMake(0+offset_x, 0+offset_y, width, height))
        background.image = UIImage(named: "TITLE_SCREEN_FARM")
        background.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(background)
        self.view.sendSubviewToBack(background)
        
        let cloud = UIImageView(frame: CGRectMake(-800+offset_x, 0+offset_y, width, height))
        cloud.image = UIImage(named: "TITLE_SCREEN_CLOUDS")
        cloud.contentMode = UIViewContentMode.ScaleAspectFill
        cloud.tag = 1
        self.view.addSubview(cloud)
        
        let playImg = UIImageView(frame: CGRectMake(0+offset_x, 0+offset_y, width, height))
        playImg.image = UIImage(named: "TITLE_SCREEN_BUTTON_PLAY_NORMAL")
        playImg.contentMode = UIViewContentMode.ScaleAspectFill
        playImg.tag = 2
        self.view.addSubview(playImg)
        
        let playText = UIImageView(frame: CGRectMake(0+offset_x, 0+offset_y, width, height))
        playText.image = UIImage(named: "TITLE_SCREEN_BUTTON_PLAY_TEXT")
        playText.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(playText)
        
        let r = 300/1800*height
        let h = 600/1800*height
        
        let button_play = UIButton(type: UIButtonType.System) as UIButton
        button_play.frame = CGRectMake(820/2850*width+offset_x, h+offset_y, r, r)
        button_play.backgroundColor =  UIColor.clearColor()
        button_play.layer.cornerRadius = 0.5 * button_play.bounds.size.width
        button_play.addTarget(self, action: "buttonTransit:", forControlEvents: UIControlEvents.TouchUpInside)
        button_play.addTarget(self, action: "buttonActivate:", forControlEvents: UIControlEvents.TouchDown)
        button_play.addTarget(self, action: "buttonDeactivate:", forControlEvents: UIControlEvents.TouchUpOutside)
        button_play.tag = 3
        self.view.addSubview(button_play)
        
        let duelImg = UIImageView(frame: CGRectMake(0+offset_x, 0+offset_y, width, height))
        duelImg.image = UIImage(named: "TITLE_SCREEN_BUTTON_DUEL_NORMAL")
        duelImg.contentMode = UIViewContentMode.ScaleAspectFill
        duelImg.tag = 4
        self.view.addSubview(duelImg)
        
        let duelText = UIImageView(frame: CGRectMake(0+offset_x, 0+offset_y, width, height))
        duelText.image = UIImage(named: "TITLE_SCREEN_BUTTON_DUEL_TEXT")
        duelText.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(duelText)
        
        let button_duel = UIButton(type: UIButtonType.System) as UIButton
        button_duel.frame = CGRectMake(1250/2850*width+offset_x, h+offset_y, r, r)
        button_duel.backgroundColor = UIColor.clearColor()
        button_duel.layer.cornerRadius = 0.5 * button_duel.bounds.size.width
        button_duel.addTarget(self, action: "buttonTransit:", forControlEvents: UIControlEvents.TouchUpInside)
        button_duel.addTarget(self, action: "buttonActivate:", forControlEvents: UIControlEvents.TouchDown)
        button_duel.addTarget(self, action: "buttonDeactivate:", forControlEvents: UIControlEvents.TouchUpOutside)
        button_duel.tag = 5
        self.view.addSubview(button_duel)
        
        let optionImg = UIImageView(frame: CGRectMake(0+offset_x, 0+offset_y, width, height))
        optionImg.image = UIImage(named: "TITLE_SCREEN_BUTTON_OPTIONS_NORMAL")
        optionImg.contentMode = UIViewContentMode.ScaleAspectFill
        optionImg.tag = 6
        self.view.addSubview(optionImg)
        
        let optionText = UIImageView(frame: CGRectMake(0+offset_x, 0+offset_y, width, height))
        optionText.image = UIImage(named: "TITLE_SCREEN_BUTTON_OPTIONS_TEXT")
        optionText.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(optionText)
        
        let button_opt = UIButton(type: UIButtonType.System) as UIButton
        button_opt.frame = CGRectMake(1720/2850*width+offset_x, h+offset_y, r, r)
        button_opt.backgroundColor = UIColor.clearColor()
        button_opt.layer.cornerRadius = 0.5 * button_opt.bounds.size.width
        button_opt.addTarget(self, action: "buttonTransit:", forControlEvents: UIControlEvents.TouchUpInside)
        button_opt.addTarget(self, action: "buttonActivate:", forControlEvents: UIControlEvents.TouchDown)
        button_opt.addTarget(self, action: "buttonDeactivate:", forControlEvents: UIControlEvents.TouchUpOutside)
        button_opt.tag = 7
        self.view.addSubview(button_opt)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackground()
        constants.musicPlayer.playMusic()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        moveImage(view.viewWithTag(1) as! UIImageView)
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
    
    func buttonTransit(sender: UIButton!) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tagNum = sender.tag
        var nextViewController: UIViewController
        switch (tagNum) {
        case 3:
            nextViewController = storyBoard.instantiateViewControllerWithIdentifier("CharacterMenu") as! RDRCharacterViewController
            self.presentViewController(nextViewController, animated:false, completion:nil)
            break
        case 5:
            buttonDeactivate(sender)
            break
        case 7:
            nextViewController = storyBoard.instantiateViewControllerWithIdentifier("optionMenu") as! RDROptionViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
            break
        default:
            break
        }
    }
    
    func buttonActivate(sender: UIButton!) {
        let tagNum = sender.tag - 1
        let img = view.viewWithTag(tagNum) as! UIImageView
        switch (tagNum) {
        case 2:
            img.image = UIImage(named: "TITLE_SCREEN_BUTTON_PLAY_ACTIVATED")
            break
        case 4:
            img.image = UIImage(named: "TITLE_SCREEN_BUTTON_DUEL_ACTIVATED")
            break
        case 6:
            img.image = UIImage(named: "TITLE_SCREEN_BUTTON_OPTIONS_ACTIVATED")
            break
        default:
            break
        }
        playSoundEffect("BUTTON_PRESS_3") // BUTTON_PRESS_1, BUTTON_PRESS_2
    }
    
    func buttonDeactivate(sender: UIButton!) {
        let tagNum = sender.tag - 1
        let img = view.viewWithTag(tagNum) as! UIImageView
        switch (tagNum) {
        case 2:
            img.image = UIImage(named: "TITLE_SCREEN_BUTTON_PLAY_NORMAL")
            break
        case 4:
            img.image = UIImage(named: "TITLE_SCREEN_BUTTON_DUEL_NORMAL")
            break
        case 6:
            img.image = UIImage(named: "TITLE_SCREEN_BUTTON_OPTIONS_NORMAL")
            break
        default:
            break
        }
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
