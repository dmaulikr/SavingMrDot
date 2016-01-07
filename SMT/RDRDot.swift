//
//  Dot.swift
//  SMT
//
//  Created by Haoruo Peng on 12/15/15.
//  Copyright © 2015 Haoruo Peng. All rights reserved.
//

import UIKit
import SpriteKit

class RDRDot: SKSpriteNode {
    var constants = RDRConstants()
    var motions = RDRMotions()
    var isJumping = false
    
    init() {
        let dot_stand = SKTexture(imageNamed: "DOT_" + constants.dotName + "_STAND")
        super.init(texture: dot_stand, color: UIColor.whiteColor().colorWithAlphaComponent(0.5), size: constants.dotSize)
        self.name = "dot"
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.size.width * constants.dotPhysicsBodyWidthRatio, self.size.height * constants.dotPhysicsBodyHeightRatio))
        self.physicsBody?.categoryBitMask = constants.dotCategory
        self.physicsBody?.contactTestBitMask = constants.obstacleCategory | constants.groundCategory | constants.airShipCategory //~
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.angularVelocity = 0
        self.zPosition = constants.dotZPosition
    }
    
    func runRight() {
        self.removeAllActions()
        self.runAction(motions.moveRight(constants.dotSpeed))
        self.runAction(motions.playGif("DOT_" + constants.dotName + "_Run", frames: constants.motionMap["Run"]!))
        self.runAction(motions.playSound("DOT_RUN_LOW_SPEED"))
        //self.runAction(motions.playSound("DOT_RUN_HIGH_SPEED"))
    }
    
    func jump() {
        if (!self.isJumping) {
            self.removeAllActions()
            self.runAction(motions.moveRight(constants.dotSpeed))
            self.physicsBody?.applyImpulse(constants.jumpVec)
            self.texture = SKTexture(imageNamed: "DOT_" + constants.dotName + "_JUMP")
            let rand = arc4random() % 2 + 1
            self.runAction(motions.playSound("DOT_JUMP_UP_" + String(rand)))
            self.isJumping = true
        }
    }
    
    func land() {
        self.removeAllActions()
        self.runAction(motions.playGifForOnce("DOT_" + constants.dotName + "_Jump-down", frames: constants.motionMap["Jump-down"]!))
        self.runAction(motions.playSound("DOT_JUMP_DOWN"))
        self.runRight()
        isJumping = false
    }
    
    func burn() {
        self.runAction(motions.playGifForOnce("DOT_" + constants.dotName + "_Burn", frames: constants.motionMap["Burn"]!))
        self.runAction(motions.playSound("DOT_BURN"))
    }
    
    func fall() {
        self.runAction(motions.playGifForOnce("DOT_" + constants.dotName + "_Fall", frames: constants.motionMap["Fall"]!))
        self.runAction(motions.playSound("DOT_FALL"))
    }
    
    func hurtBefore() {
        self.runAction(motions.playGifForOnce("DOT_" + constants.dotName + "_Hurt-before", frames: constants.motionMap["Hurt-before"]!))
        self.runAction(motions.playSound("DOT_HURT"))
    }
    
    func hurtAfter() {
        self.runAction(motions.playGifForOnce("DOT_" + constants.dotName + "_Hurt-after", frames: constants.motionMap["Hurt-after"]!))
        self.runAction(motions.playSound("DOT_HURT_AH"))
    }
    
    func captured() {
        self.runAction(motions.playSound("DOT_CAUGHT"))
        self.runAction(motions.playSound("DOT_SCREAM_CAPTURE"))
        //self.runAction(motions.playSound("DOT_SCREAM_TANK"))
    }
    
    func stop() {
        self.removeAllActions()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
