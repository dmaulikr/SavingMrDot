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
    let dotCategory = UInt32(0x1 << 0)
    let obstacleCategory = UInt32(0x1 << 1)
    let groundCategory = UInt32(0x1 << 2)
    
    let dotZPosition = CGFloat(1.0)
    
    let dotPosition = CGPointMake(0, -10)
    let pointPosition = CGPointMake(-150, 70)
    
    let gameFont = "Helvetica" // AmericanTypewriter-Bold
    let textSize = CGFloat(20)
    
}

//self.backgroundColor = SKColor.colorWithAlphaComponent()
//let dot = self.childNodeWithName("dot") as! RDRDot
//pointsLabel.removeFromParent()
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