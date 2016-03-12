//
//  RDRMenuViewController.swift
//  RunDotRun
//
//  Created by Haoruo Peng on 1/15/16.
//  Copyright © 2016 Haoruo Peng. All rights reserved.
//

import UIKit
import SpriteKit

class RDRMenuViewController: UIViewController {
    var soundEffects = [String: RDRAudioPlayer]()
    
    func addBackground() {
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let background = UIImageView(frame: CGRectMake(0, 0, width, height))
        background.image = UIImage(named: "MENU_SCREEN_SKY")
        background.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(background)
        self.view.sendSubviewToBack(background)
        
        let backImg = UIImageView(frame: CGRectMake(0, 0, width, height))
        backImg.image = UIImage(named: "MENU_SCREEN_BUTTON_BACK_NORMAL")
        backImg.contentMode = UIViewContentMode.ScaleAspectFill
        backImg.tag = 2
        self.view.addSubview(backImg)
        
        let backText = UIImageView(frame: CGRectMake(0, 0, width, height))
        backText.image = UIImage(named: "MENU_SCREEN_BUTTON_BACK_TEXT")
        backText.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(backText)
        
        let button_back = UIButton(type: UIButtonType.System) as UIButton
        button_back.frame = CGRectMake(30/667*width, 10/375*height, 66/667*width, 60/375*height)
        button_back.backgroundColor =  UIColor.clearColor()
        button_back.layer.cornerRadius = 0.5 * button_back.bounds.size.width
        button_back.addTarget(self, action: "buttonTransit:", forControlEvents: UIControlEvents.TouchUpInside)
        button_back.addTarget(self, action: "buttonActivate:", forControlEvents: UIControlEvents.TouchDown)
        button_back.addTarget(self, action: "buttonDeactivate:", forControlEvents: UIControlEvents.TouchUpOutside)
        button_back.tag = 3
        self.view.addSubview(button_back)
        
        let scoresImg = UIImageView(frame: CGRectMake(0, 0, width, height))
        scoresImg.image = UIImage(named: "MENU_SCREEN_BUTTON_SCORES_NORMAL")
        scoresImg.contentMode = UIViewContentMode.ScaleAspectFill
        scoresImg.tag = 4
        self.view.addSubview(scoresImg)
        
        let scoresText = UIImageView(frame: CGRectMake(0, 0, width, height))
        scoresText.image = UIImage(named: "MENU_SCREEN_BUTTON_SCORES_TEXT")
        scoresText.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(scoresText)
        
        let button_scores = UIButton(type: UIButtonType.System) as UIButton
        button_scores.frame = CGRectMake(190/667*width, 125/375*height, 66/667*width, 60/375*height)
        button_scores.backgroundColor = UIColor.clearColor()
        button_scores.layer.cornerRadius = 0.5 * button_scores.bounds.size.width
        button_scores.addTarget(self, action: "buttonTransit:", forControlEvents: UIControlEvents.TouchUpInside)
        button_scores.addTarget(self, action: "buttonActivate:", forControlEvents: UIControlEvents.TouchDown)
        button_scores.addTarget(self, action: "buttonDeactivate:", forControlEvents: UIControlEvents.TouchUpOutside)
        button_scores.tag = 5
        self.view.addSubview(button_scores)
        
        let shareImg = UIImageView(frame: CGRectMake(0, 0, width, height))
        shareImg.image = UIImage(named: "MENU_SCREEN_BUTTON_SHARE_NORMAL")
        shareImg.contentMode = UIViewContentMode.ScaleAspectFill
        shareImg.tag = 6
        self.view.addSubview(shareImg)
        
        let shareText = UIImageView(frame: CGRectMake(0, 0, width, height))
        shareText.image = UIImage(named: "MENU_SCREEN_BUTTON_SHARE_TEXT")
        shareText.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(shareText)
        
        let button_share = UIButton(type: UIButtonType.System) as UIButton
        button_share.frame = CGRectMake(340/667*width, 125/375*height, 66/667*width, 60/375*height)
        button_share.backgroundColor = UIColor.clearColor()
        button_share.layer.cornerRadius = 0.5 * button_share.bounds.size.width
        button_share.addTarget(self, action: "buttonTransit:", forControlEvents: UIControlEvents.TouchUpInside)
        button_share.addTarget(self, action: "buttonActivate:", forControlEvents: UIControlEvents.TouchDown)
        button_share.addTarget(self, action: "buttonDeactivate:", forControlEvents: UIControlEvents.TouchUpOutside)
        button_share.tag = 7
        self.view.addSubview(button_share)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackground()
    }
    
    func buttonTransit(sender: UIButton!) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tagNum = sender.tag
        var nextViewController: UIViewController
        switch (tagNum) {
        case 3:
            nextViewController = storyBoard.instantiateViewControllerWithIdentifier("GameView") as! GameViewController
            self.presentViewController(nextViewController, animated:false, completion:nil)
            break
        case 5:
            nextViewController = storyBoard.instantiateViewControllerWithIdentifier("TitleMenu") as! RDRTitleViewController
            self.presentViewController(nextViewController, animated:false, completion:nil)
            break
        case 7:
            buttonDeactivate(sender)
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
            img.image = UIImage(named: "MENU_SCREEN_BUTTON_BACK_ACTIVATED")
            break
        case 4:
            img.image = UIImage(named: "MENU_SCREEN_BUTTON_SCORES_ACTIVATED")
            break
        case 6:
            img.image = UIImage(named: "MENU_SCREEN_BUTTON_SHARE_ACTIVATED")
            break
        default:
            break
        }
        playSoundEffect("BUTTON_PRESS_1") // BUTTON_PRESS_2, BUTTON_PRESS_3
    }
    
    func buttonDeactivate(sender: UIButton!) {
        let tagNum = sender.tag - 1
        let img = view.viewWithTag(tagNum) as! UIImageView
        switch (tagNum) {
        case 2:
            img.image = UIImage(named: "MENU_SCREEN_BUTTON_BACK_NORMAL")
            break
        case 4:
            img.image = UIImage(named: "MENU_SCREEN_BUTTON_SCORES_NORMAL")
            break
        case 6:
            img.image = UIImage(named: "MENU_SCREEN_BUTTON_SHARE_NORMAL")
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