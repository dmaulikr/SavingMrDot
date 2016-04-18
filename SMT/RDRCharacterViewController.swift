//
//  RDRCharacterViewController.swift
//  RunDotRun
//
//  Created by Haoruo Peng on 1/15/16.
//  Copyright © 2016 Haoruo Peng. All rights reserved.
//

import UIKit
import SpriteKit

class RDRCharacterViewController: UIViewController {
    var soundEffects = [String: RDRAudioPlayer]()
    
    func addBackground() {
        //let width = UIScreen.mainScreen().bounds.size.width
        //let height = UIScreen.mainScreen().bounds.size.height
        //let height = width / 16 * 9
        
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
        
        let sky = UIImageView(frame: CGRectMake(0+offset_x, 0+offset_y, width, height))
        sky.image = UIImage(named: "SCREEN_SKY")
        sky.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(sky)
        
        let background = UIImageView(frame: CGRectMake(0+offset_x, 0+offset_y, width, height))
        background.image = UIImage(named: "CHARACTER_SCREEN_FARM")
        background.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(background)
        self.view.sendSubviewToBack(background)
        self.view.sendSubviewToBack(sky)
        
        let cloud = UIImageView(frame: CGRectMake(-800+offset_x, 0+offset_y, width, height))
        cloud.image = UIImage(named: "SCREEN_CLOUDS")
        cloud.contentMode = UIViewContentMode.ScaleAspectFill
        cloud.tag = 1
        self.view.addSubview(cloud)
        
        let jeanImg = UIImageView(frame: CGRectMake(0+offset_x, 0+offset_y, width, height))
        jeanImg.image = UIImage(named: "CHARACTER_SCREEN_BUTTON_JEAN_NORMAL")
        jeanImg.contentMode = UIViewContentMode.ScaleAspectFill
        jeanImg.tag = 2
        self.view.addSubview(jeanImg)
        
        let jeanText = UIImageView(frame: CGRectMake(0+offset_x, 0+offset_y, width, height))
        jeanText.image = UIImage(named: "CHARACTER_SCREEN_BUTTON_JEAN_TEXT")
        jeanText.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(jeanText)
        
        let button_jean = UIButton(type: UIButtonType.System) as UIButton
        button_jean.frame = CGRectMake(245/667*width+offset_x, 140/375*height+offset_y, 70/667*width, 110/375*height)
        button_jean.backgroundColor =  UIColor.clearColor()
        button_jean.layer.cornerRadius = 0.3 * button_jean.bounds.size.height
        button_jean.addTarget(self, action: "buttonTransit:", forControlEvents: UIControlEvents.TouchUpInside)
        button_jean.addTarget(self, action: "buttonActivate:", forControlEvents: UIControlEvents.TouchDown)
        button_jean.addTarget(self, action: "buttonDeactivate:", forControlEvents: UIControlEvents.TouchUpOutside)
        button_jean.tag = 3
        self.view.addSubview(button_jean)
        
        let captainImg = UIImageView(frame: CGRectMake(0+offset_x, 0+offset_y, width, height))
        captainImg.image = UIImage(named: "CHARACTER_SCREEN_BUTTON_CAPTAIN_NORMAL")
        captainImg.contentMode = UIViewContentMode.ScaleAspectFill
        captainImg.tag = 4
        self.view.addSubview(captainImg)
        
        let captainText = UIImageView(frame: CGRectMake(0+offset_x, 0+offset_y, width, height))
        captainText.image = UIImage(named: "CHARACTER_SCREEN_BUTTON_CAPTAIN_TEXT")
        captainText.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(captainText)
        
        let button_captain = UIButton(type: UIButtonType.System) as UIButton
        button_captain.frame = CGRectMake(365/667*width+offset_x, 145/375*height+offset_y, 85/667*width, 130/375*height)
        button_captain.backgroundColor = UIColor.clearColor()
        button_captain.layer.cornerRadius = 0.3 * button_captain.bounds.size.height
        button_captain.addTarget(self, action: "buttonTransit:", forControlEvents: UIControlEvents.TouchUpInside)
        button_captain.addTarget(self, action: "buttonActivate:", forControlEvents: UIControlEvents.TouchDown)
        button_captain.addTarget(self, action: "buttonDeactivate:", forControlEvents: UIControlEvents.TouchUpOutside)
        button_captain.tag = 5
        self.view.addSubview(button_captain)
        
        let zippyImg = UIImageView(frame: CGRectMake(0+offset_x, 0+offset_y, width, height))
        zippyImg.image = UIImage(named: "CHARACTER_SCREEN_BUTTON_ZIPPY_NORMAL")
        zippyImg.contentMode = UIViewContentMode.ScaleAspectFill
        zippyImg.tag = 6
        self.view.addSubview(zippyImg)
        
        let zippyText = UIImageView(frame: CGRectMake(0+offset_x, 0+offset_y, width, height))
        zippyText.image = UIImage(named: "CHARACTER_SCREEN_BUTTON_ZIPPY_TEXT")
        zippyText.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(zippyText)
        
        let button_zippy = UIButton(type: UIButtonType.System) as UIButton
        button_zippy.frame = CGRectMake(470/667*width+offset_x, 225/375*height+offset_y, 95/667*width, 105/375*height)
        button_zippy.backgroundColor = UIColor.clearColor()
        button_zippy.layer.cornerRadius = 0.3 * button_zippy.bounds.size.height
        button_zippy.addTarget(self, action: "buttonTransit:", forControlEvents: UIControlEvents.TouchUpInside)
        button_zippy.addTarget(self, action: "buttonActivate:", forControlEvents: UIControlEvents.TouchDown)
        button_zippy.addTarget(self, action: "buttonDeactivate:", forControlEvents: UIControlEvents.TouchUpOutside)
        button_zippy.tag = 7
        self.view.addSubview(button_zippy)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackground()
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
            constants.dotName = "JEAN"
            nextViewController = storyBoard.instantiateViewControllerWithIdentifier("GameView") as! GameViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
            break
        case 5:
            constants.dotName = "CAPTAIN"
            nextViewController = storyBoard.instantiateViewControllerWithIdentifier("GameView") as! GameViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
            break
        case 7:
            constants.dotName = "ZIPPY"
            nextViewController = storyBoard.instantiateViewControllerWithIdentifier("GameView") as! GameViewController
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
            img.image = UIImage(named: "CHARACTER_SCREEN_BUTTON_JEAN_ACTIVATED")
            break
        case 4:
            img.image = UIImage(named: "CHARACTER_SCREEN_BUTTON_CAPTAIN_ACTIVATED")
            break
        case 6:
            img.image = UIImage(named: "CHARACTER_SCREEN_BUTTON_ZIPPY_ACTIVATED")
            break
        default:
            break
        }
        playSoundEffect("BUTTON_PRESS_2") // BUTTON_PRESS_1, BUTTON_PRESS_3
    }
    
    func buttonDeactivate(sender: UIButton!) {
        let tagNum = sender.tag - 1
        let img = view.viewWithTag(tagNum) as! UIImageView
        switch (tagNum) {
        case 2:
            img.image = UIImage(named: "CHARACTER_SCREEN_BUTTON_JEAN_NORMAL")
            break
        case 4:
            img.image = UIImage(named: "CHARACTER_SCREEN_BUTTON_CAPTAIN_NORMAL")
            break
        case 6:
            img.image = UIImage(named: "CHARACTER_SCREEN_BUTTON_ZIPPY_NORMAL")
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