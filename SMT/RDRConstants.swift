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
    
    let dotSize = CGSizeMake(80, 80)
    let dotPhysicsBodyWidthRatio = CGFloat(0.56)
    let dotPhysicsBodyHeightRatio = CGFloat(0.80)
    let airShipSize = CGSizeMake(316, 200)
    let airShipPhysicsBodyWidthRatio = CGFloat(0.10)
    let airShipPhysicsBodyHeightRatio = CGFloat(0.10)
    let obstacleSize = CGSizeMake(20, 40)
    let hiddengroundHeight = CGFloat(10)
    
    let gameFont = "Helvetica" // AmericanTypewriter-Bold
    let textSize = CGFloat(20)
    
    let jumpVec = Double(100)
    var dotSpeed = Double(150)
    var dotHorizonSpeed = Double(50)
    var airShipSpeed = Double(120)
    
    let musicVolume = Float(0.08)
    let backgroundVolume = Float(0.5)
    
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
    
    init() {
    }
}

//self.backgroundColor = SKColor.colorWithAlphaComponent()
//let dot = self.childNodeWithName("dot") as! RDRDot
//pointsLabel.removeFromParent()
//constants.gameDN.uppercaseString
/*
for touch in touches {
let location = touch.locationInNode(self)

let sprite = SKSpriteNode(imageNamed:"Spaceship")

sprite.xScale = 0.5
sprite.yScale = 0.5
sprite.position = location

let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)

sprite.runAction(SKAction.repeatActionForever(action))

self.addChild(sprite)
}
*/

// CAPTURE-motion
// Obstacle
// MENU