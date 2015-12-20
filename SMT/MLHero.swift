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
    let heroCategory = UInt32(0x1 << 0)
    let obstacleCategory = UInt32(0x1 << 1)
    let groundCategory = UInt32(0x1 << 2)
    
    init() {
        let dot_stand = SKTexture(imageNamed: "RDR_DOT_JEAN-SHORTS_STAND_R_DAY_01")
        super.init(texture: dot_stand, color: UIColor.whiteColor().colorWithAlphaComponent(0.5), size: CGSizeMake(40, 40))
        self.name = "hero"
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        self.physicsBody?.categoryBitMask = heroCategory
        self.physicsBody?.contactTestBitMask = obstacleCategory | ~groundCategory
        self.zPosition = 1
    }
    
    func runRight() {
        let incrementalRight = SKAction.moveByX(1.0, y: 0, duration: 0.01)
        let moveRight = SKAction.repeatActionForever(incrementalRight)
        self.runAction(moveRight)
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
