//
//  RDROptionViewController.swift
//  RunDotRun
//
//  Created by Haoruo Peng on 1/15/16.
//  Copyright © 2016 Haoruo Peng. All rights reserved.
//

import UIKit
import SpriteKit

class RDROptionViewController: UIViewController {
    var soundEffects = [String: RDRAudioPlayer]()
    
    func addBackground() {
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let background = UIImageView(frame: CGRectMake(0, 0, width, height))
        background.image = UIImage(named: "OPTIONS_SCREEN_BACKGROUND")
        background.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(background)
        self.view.sendSubviewToBack(background)
        
        let sliders = UIImageView(frame: CGRectMake(0, 0, width, height))
        sliders.image = UIImage(named: "OPTIONS_SCREEN_SLIDERS")
        sliders.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(sliders)
        
        let text = UIImageView(frame: CGRectMake(0, 0, width, height))
        text.image = UIImage(named: "OPTIONS_SCREEN_TEXT")
        text.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(text)
        
        let backImg = UIImageView(frame: CGRectMake(0, 0, width, height))
        backImg.image = UIImage(named: "OPTIONS_SCREEN_BUTTON_BACK_NORMAL")
        backImg.contentMode = UIViewContentMode.ScaleAspectFill
        backImg.tag = 1
        self.view.addSubview(backImg)
        
        let backText = UIImageView(frame: CGRectMake(0, 0, width, height))
        backText.image = UIImage(named: "OPTIONS_SCREEN_BUTTON_BACK_TEXT")
        backText.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(backText)
        
        let button_back = UIButton(type: UIButtonType.System) as UIButton
        button_back.frame = CGRectMake(30, 10, 66, 60)
        button_back.backgroundColor =  UIColor.clearColor()
        button_back.layer.cornerRadius = 0.5 * button_back.bounds.size.width
        button_back.addTarget(self, action: "buttonTransit:", forControlEvents: UIControlEvents.TouchUpInside)
        button_back.addTarget(self, action: "buttonActivate:", forControlEvents: UIControlEvents.TouchDown)
        button_back.addTarget(self, action: "buttonDeactivate:", forControlEvents: UIControlEvents.TouchUpOutside)
        button_back.tag = 2
        self.view.addSubview(button_back)
        
        let sliderSound = UISlider(frame:CGRectMake(285, 115, 245, 20))
        sliderSound.minimumValue = 0
        sliderSound.value = constants.soundVolume
        sliderSound.maximumValue = 1
        sliderSound.continuous = true
        sliderSound.setMinimumTrackImage(UIImage(), forState: .Normal)
        sliderSound.setMaximumTrackImage(UIImage(), forState: .Normal)
        sliderSound.setThumbImage(scaleUIImageToSize(UIImage(named: "KNOB")!, size: CGSizeMake(30,30)), forState: UIControlState.Normal)
        sliderSound.addTarget(self, action: "sliderValueDidChange:", forControlEvents: .ValueChanged)
        sliderSound.tag = 3
        self.view.addSubview(sliderSound)
        
        let sliderMusic = UISlider(frame:CGRectMake(285, 158, 245, 20))
        sliderMusic.minimumValue = 0
        sliderMusic.value = constants.musicVolume
        sliderMusic.maximumValue = 1
        sliderMusic.continuous = true
        sliderMusic.setMinimumTrackImage(UIImage(), forState: .Normal)
        sliderMusic.setMaximumTrackImage(UIImage(), forState: .Normal)
        sliderMusic.setThumbImage(scaleUIImageToSize(UIImage(named: "KNOB")!, size: CGSizeMake(30,30)), forState: UIControlState.Normal)
        sliderMusic.addTarget(self, action: "sliderValueDidChange:", forControlEvents: .ValueChanged)
        sliderMusic.tag = 4
        self.view.addSubview(sliderMusic)
        
        let sliderDiff = UISlider(frame:CGRectMake(285, 203, 245, 20))
        sliderDiff.minimumValue = 0
        sliderDiff.value = constants.difficulty
        sliderDiff.maximumValue = 1
        sliderDiff.continuous = true
        sliderDiff.setMinimumTrackImage(UIImage(), forState: .Normal)
        sliderDiff.setMaximumTrackImage(UIImage(), forState: .Normal)
        sliderDiff.setThumbImage(scaleUIImageToSize(UIImage(named: "KNOB")!, size: CGSizeMake(30,30)), forState: UIControlState.Normal)
        sliderDiff.addTarget(self, action: "sliderValueDidChange:", forControlEvents: .ValueChanged)
        sliderDiff.tag = 5
        self.view.addSubview(sliderDiff)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackground()
        constants.musicPlayer.playMusic()
    }
    
    func buttonTransit(sender: UIButton!) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tagNum = sender.tag
        var nextViewController: UIViewController
        switch (tagNum) {
        case 2:
            nextViewController = storyBoard.instantiateViewControllerWithIdentifier("TitleMenu") as! RDRTitleViewController
            self.presentViewController(nextViewController, animated:false, completion:nil)
            break
        default:
            break
        }
    }
    
    func buttonActivate(sender: UIButton!) {
        let tagNum = sender.tag - 1
        let img = view.viewWithTag(tagNum) as! UIImageView
        switch (tagNum) {
        case 1:
            img.image = UIImage(named: "OPTIONS_SCREEN_BUTTON_BACK_ACTIVATED")
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
        case 1:
            img.image = UIImage(named: "OPTIONS_SCREEN_BUTTON_BACK_NORMAL")
            break
        default:
            break
        }
    }
    
    func sliderValueDidChange(sender: UISlider!)
    {
        let tagNum = sender.tag
        switch (tagNum) {
        case 3:
            constants.soundVolume = sender.value
            break
        case 4:
            constants.musicVolume = sender.value
            constants.musicPlayer.setVolume(constants.musicVolume)
            break
        case 5:
            constants.difficulty = sender.value
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
    
    func scaleUIImageToSize(image: UIImage, size: CGSize) -> UIImage {
        let hasAlpha = true
        let scale: CGFloat = 0.0
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
}