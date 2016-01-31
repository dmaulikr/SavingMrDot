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
    func addBackground() {
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let background = UIImageView(frame: CGRectMake(0, 0, width, height))
        background.image = UIImage(named: "TITLE_SCREEN_FARM")
        background.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(background)
        self.view.sendSubviewToBack(background)
        
        let cloud = UIImageView(frame: CGRectMake(0, 0, width, height))
        cloud.image = UIImage(named: "TITLE_SCREEN_CLOUDS")
        cloud.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(cloud)
        moveImage(cloud)
        //self.view.sendSubviewToBack(cloud)
        
        let optionImg = UIImageView(frame: CGRectMake(0, 0, width, height))
        optionImg.image = UIImage(named: "TITLE_SCREEN_BUTTON_OPTIONS_NORMAL")
        optionImg.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(optionImg)
        
        let button   = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(400, 125, 66, 60)
        button.backgroundColor = UIColor.clearColor()
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackground()
    }
    
    func moveImage(view: UIImageView){
        let toPoint: CGPoint = CGPointMake(800.0, 0.0)
        let fromPoint : CGPoint = CGPointMake(-800.0, 0.0)
        
        let movement = CABasicAnimation(keyPath: "position")
        movement.additive = true
        movement.fromValue =  NSValue(CGPoint: fromPoint)
        movement.toValue =  NSValue(CGPoint: toPoint)
        movement.repeatCount = Float.infinity
        movement.duration = 20
        view.layer.addAnimation(movement, forKey: "move")
    }
    
    func buttonAction(sender:UIButton!) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("optionMenu") as! RDROptionViewController
        self.presentViewController(nextViewController, animated:true, completion:nil)
    }
}
