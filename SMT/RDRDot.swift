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
        let dot_stand = SKTexture(imageNamed: "DOT_JEAN_STAND")
        super.init(texture: dot_stand, color: UIColor.whiteColor().colorWithAlphaComponent(0.5), size: constants.dotSize)
        self.name = "dot"
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        self.physicsBody?.categoryBitMask = constants.dotCategory
        self.physicsBody?.contactTestBitMask = constants.obstacleCategory | constants.groundCategory //~
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.angularVelocity = 0
        self.zPosition = constants.dotZPosition
    }
    
    func runRight() {
        self.runAction(motions.moveRight())
        self.runAction(motions.playGif("DOT_JEAN_Run", frames: constants.motionMap["Run"]!))
    }
    
    func jump() {
        if (!self.isJumping) {
            self.physicsBody?.applyImpulse(constants.jumpVec)
            self.runAction(motions.playSound("DOT_JUMP_UP_1"))
            self.isJumping = true
        }
    }
    
    func land() {
        isJumping = false
    }
    
    func stop() {
        self.removeAllActions()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
