//
//  RDRAirShip.swift
//  RunDotRun
//
//  Created by Haoruo Peng on 1/6/16.
//  Copyright © 2016 Haoruo Peng. All rights reserved.
//

import UIKit
import SpriteKit

class RDRAirShip: SKSpriteNode {
    var constants = RDRConstants()
    var motions = RDRMotions()
    
    init() {
        let ship_closed = SKTexture(imageNamed: "AIRSHIP_CLOSED")
        super.init(texture: ship_closed, color: UIColor.whiteColor().colorWithAlphaComponent(0.5), size: constants.airShipSize)
        self.name = "airship"
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.size.width * constants.airShipPhysicsBodyWidthRatio, self.size.height * constants.airShipPhysicsBodyHeightRatio))
        self.physicsBody?.categoryBitMask = constants.airShipCategory
        self.physicsBody?.contactTestBitMask = constants.dotCategory | ~constants.obstacleCategory
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.angularVelocity = 0
        self.zPosition = constants.airShipZPosition
    }
    
    func open() {
        self.runAction(SKAction.sequence([motions.playGifForOnce("AIRSHIP_OPEN", frames: constants.motionMap["OPEN"]!), motions.playGif("AIRSHIP_IDLE", frames: constants.motionMap["IDLE"]!)]))
        self.runAction(motions.playSound("AIRSHIP_OPEN"))
    }
    
    func moveRight() {
        self.runAction(motions.moveRight(constants.airShipSpeed))
        self.runAction(motions.playGif("AIRSHIP_IDLE", frames: constants.motionMap["IDLE"]!))
        self.runAction(SKAction.repeatActionForever(motions.playSound("AIRSHIP_FLY_BY")))
        //self.runAction(motions.playSound("AIRSHIP_FLY_IN"))
        //self.runAction(motions.playSound("AIRSHIP_FLY_AWAY"))
    }
    
    func close() {
        self.runAction(motions.playGif("AIRSHIP_CLOSE", frames: constants.motionMap["CLOSE"]!))
        self.runAction(motions.playSound("AIRSHIP_CLOSE"))
    }
    
    func capture() {
        self.runAction(motions.playGif("AIRSHIP_CAPTURE_" + constants.dotName, frames: constants.motionMap["CAPTURE"]!))
        self.runAction(motions.playSound("AIRSHIP_CAPTURE"))
    }
    
    func noshipFishDown() {
        self.runAction(motions.playGif("AIRSHIP_NOSHIP_FISH_DOWN", frames: constants.motionMap["NOSHIP_FISH_DOWN"]!))
        self.runAction(motions.playSound("AIRSHIP_FISH_DOWN"))
    }
    
    func noshipFishUp() {
        self.runAction(motions.playGif("AIRSHIP_NOSHIP_FISH_UP_" + constants.dotName, frames: constants.motionMap["NOSHIP_FISH_UP"]!))
        self.runAction(motions.playSound("AIRSHIP_FISH_UP"))
    }
    
    func shipFishDown() {
        self.runAction(motions.playGif("AIRSHIP_SHIP_FISH_DOWN", frames: constants.motionMap["SHIP_FISH_DOWN"]!))
        self.runAction(motions.playSound("AIRSHIP_FISH_DOWN"))
    }
    
    func shipFishUp() {
        self.runAction(motions.playGif("AIRSHIP_SHIP_FISH_UP_" + constants.dotName, frames: constants.motionMap["SHIP_FISH_UP"]!))
        self.runAction(motions.playSound("AIRSHIP_FISH_UP"))
    }
    
    func reach() {
        self.runAction(motions.playGif("AIRSHIP_REACH", frames: constants.motionMap["REACH"]!))
        self.runAction(motions.playSound("AIRSHIP_REACH"))
    }
    // CLAW_REACH
    func retract() {
        self.runAction(motions.playGif("AIRSHIP_RETRACT", frames: constants.motionMap["RETRACT"]!))
        self.runAction(motions.playSound("AIRSHIP_REACH"))
    }
    
    func stop() {
        self.removeAllActions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
