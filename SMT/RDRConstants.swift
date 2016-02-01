//
//  MyConstants.swift
//  SMT
//
//  Created by Haoruo Peng on 12/19/15.
//  Copyright © 2015 Haoruo Peng. All rights reserved.
//

import Foundation
import SpriteKit

class RDRConstants {
    var dotName = "JEAN" // CAPTAIN ZIPPY
    var musicVolume = Float(0.08)
    var backgroundVolume = Float(0.5)
    var soundVolume = Float(0.9)
    var difficulty = Float(0.5)
    
    var gameDN = "day" // night
    
    let dotCategory = UInt32(0x1 << 0)
    let obstacleCategory = UInt32(0x1 << 1)
    let groundCategory = UInt32(0x1 << 2)
    let airShipCategory = UInt32(0x1 << 3)
    
    let dotZPosition = CGFloat(1.0)
    let hiddengroundZPosition = CGFloat(-1.0)
    let backgroundZPosition = CGFloat(-0.9)
    let groundZPosition = CGFloat(-0.5)
    let airShipZPosition = CGFloat(0.5)
    
    let dotPosition = CGPointMake(0, -10)
    let airShipPosition = CGPointMake(-75, 10)
    let pointPosition = CGPointMake(-150, 70)
    let initObstacleX = CGFloat(200)
    
    let dotSize = CGSizeMake(25, 25)
    let dotPhysicsBodyWidthRatio = CGFloat(0.56)
    let dotPhysicsBodyHeightRatio = CGFloat(0.80)
    
    let airShipSize = CGSizeMake(316, 200)
    let airShipPhysicsBodyWidthRatio = CGFloat(0.20)
    let airShipPhysicsBodyHeightRatio = CGFloat(2.0)
    
    let holeSize = CGSizeMake(50, 20)
    let holePhysicsBodyWidthRatio = CGFloat(0.3)
    
    let rockBigSize = CGSizeMake(40, 60)
    let rockBigPhysicsBodyWidthRatio = CGFloat(0.9)
    let rockBigPhysicsBodyHeightRatio = CGFloat(0.8)
    
    let rockMediumSize = CGSizeMake(40, 40)
    let rockMediumPhysicsBodyWidthRatio = CGFloat(0.8)
    let rockMediumPhysicsBodyHeightRatio = CGFloat(0.8)
    
    let rockSmallSize = CGSizeMake(40, 30)
    let rockSmallPhysicsBodyWidthRatio = CGFloat(0.7)
    let rockSmallPhysicsBodyHeightRatio = CGFloat(0.8)
    
    let fireSize = CGSizeMake(30, 72)
    let firePhysicsBodyWidthRatio = CGFloat(0.7)
    let firePhysicsBodyHeightRatio = CGFloat(0.4)
    
    let hiddengroundHeight = CGFloat(10)
    
    let gameFont = "Helvetica" // AmericanTypewriter-Bold
    let textSize = CGFloat(20)
    
    let jumpVec = Double(10)
    let dotSpeed = Double(150)
    let dotHorizonSpeed = Double(50)
    let airShipSpeed = Double(120)
    let airShipGameOverSpeed = Double(6)
    let dotFadeOutTime = Double(0.1)
    let airShipFadeOutTime = Double(0.1)
    
    let shipInSceneCorrection = CGFloat(200)
    let shipDotAlignCorrection = CGFloat(37)
    
    let y2 = 600
    let y1 = 300
    let alpha = 6
    let step = Int(8)
    
    let motionMap = [
        "Run"              : 9,
        "Fall"             : 9,
        "Burn"             : 11,
        "Hurt-before"      : 2,
        "Hurt-after"       : 11,
        "Jump-down"        : 1,
        "Jump-up"          : 1,
        
        "FIRE-BEGIN"       : 14,
        "FIRE-DURING"      : 8,
        "FIRE-END"         : 14,
        
        "CAPTURE"          : 33,
        "CLOSE"            : 12,
        "IDLE"             : 37,
        "NOSHIP_FISH_DOWN" : 9,
        "NOSHIP_FISH_UP"   : 10,
        "OPEN"             : 20,
        "REACH"            : 2,
        "RETRACT"          : 2,
        "SHIP_FISH_DOWN"   : 5,
        "SHIP_FISH_UP"     : 4
    ]
    
    let timeGapMap = [
        ["hole", false]    : 2.0,
        ["hole", true]     : 2.0,
        ["rock", false]    : 2.0,
        ["rock", true]     : 2.0,
        ["fire", false]    : 2.0,
        ["fire", true]     : 2.0,
    ]
    
    let musicPlayer = RDRAudioPlayer(filename: "MUSIC", num: -1)
    
    init() {
        musicPlayer.setVolume(musicVolume)
    }
}

var constants = RDRConstants()

//self.backgroundColor = SKColor.colorWithAlphaComponent()
//let dot = self.childNodeWithName("dot") as! RDRDot
//pointsLabel.removeFromParent()
//self.view.sendSubviewToBack(cloud)
//button.backgroundColor = UIColor.greenColor()

// Refine all Contacts
// video: https://youtu.be/IfOKH5kVLGo
// test on otehr devices

// Share + Wind + Vibration
// Ad: https://developer.apple.com/iad/monetize/