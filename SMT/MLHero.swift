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
    init() {
        let dot_stand = SKTexture(imageNamed: "RDR_DOT_JEAN-SHORTS_STAND_R_DAY_01")
        super.init(texture: dot_stand, color: UIColor.whiteColor().colorWithAlphaComponent(0.5), size: CGSizeMake(20, 20))
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        self.name = "hero"
    }
    
    func runRight() {
        let incrementalRight = SKAction.moveByX(1.0, y: 0, duration: 0.01)
        let moveRight = SKAction.repeatActionForever(incrementalRight)
        self.runAction(moveRight)
    }
    
    func jump() {
        self.physicsBody?.applyImpulse(CGVectorMake(0, 10))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
