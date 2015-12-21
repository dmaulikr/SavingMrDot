//
//  MLHero.swift
//  SMT
//
//  Created by Haoruo Peng on 12/15/15.
//  Copyright © 2015 Haoruo Peng. All rights reserved.
//

import UIKit
import SpriteKit

class MLHero: SKSpriteNode {
    var constants = MyConstants()
    
    init() {
        let dot_stand = SKTexture(imageNamed: "DOT_JEAN_STAND")
        super.init(texture: dot_stand, color: UIColor.whiteColor().colorWithAlphaComponent(0.5), size: CGSizeMake(80, 80))
        self.name = "hero"
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        self.physicsBody?.categoryBitMask = constants.heroCategory
        self.physicsBody?.contactTestBitMask = constants.obstacleCategory | ~constants.groundCategory
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.angularVelocity = 0
        self.zPosition = 1
    }
    
    func runRight() {
        let incrementalRight = SKAction.moveByX(1.0, y: 0, duration: 0.01)
        let moveRight = SKAction.repeatActionForever(incrementalRight)
        self.runAction(moveRight)
        
        var gifTextures: [SKTexture] = []
        for i in 0...9 {
            gifTextures.append(SKTexture(imageNamed: "DOT_JEAN_Fall-\(i)"))
        }
        let runGif = SKAction.repeatActionForever(SKAction.animateWithTextures(gifTextures, timePerFrame: 0.125))
        self.runAction(runGif)
    }
    
    func jump() {
        self.physicsBody?.applyImpulse(CGVectorMake(0, 45))
    }
    
    func stop() {
        self.removeAllActions()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
