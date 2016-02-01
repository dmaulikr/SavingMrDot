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
    var motions = RDRMotions()
    var soundEffects = [String: RDRAudioPlayer]()
    
    init() {
        let ship_closed = SKTexture(imageNamed: "AIRSHIP_CLOSED")
        super.init(texture: ship_closed, color: UIColor.whiteColor().colorWithAlphaComponent(0.5), size: constants.airShipSize)
        self.name = "airship"
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.size.width * constants.airShipPhysicsBodyWidthRatio, self.size.height * constants.airShipPhysicsBodyHeightRatio))
        self.physicsBody?.categoryBitMask = constants.airShipCategory
        self.physicsBody?.contactTestBitMask = constants.dotCategory | ~constants.obstacleCategory
        self.physicsBody?.collisionBitMask = constants.dotCategory
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.angularVelocity = 0
        self.zPosition = constants.airShipZPosition
    }
    
    func open() {
        self.runAction(SKAction.sequence([motions.playGifForOnce("AIRSHIP_OPEN", frames: constants.motionMap["OPEN"]!), motions.playGif("AIRSHIP_IDLE", frames: constants.motionMap["IDLE"]!)]))
        self.playSoundEffect("AIRSHIP_OPEN")
    }
    
    func idle() {
        self.runAction(motions.playGifForOnce("AIRSHIP_IDLE", frames: constants.motionMap["IDLE"]!))
        self.playSoundEffect("AIRSHIP_FLY_BY")
        //self.playSoundEffect("AIRSHIP_FLY_IN")
    }
    
    func moveRight() {
        self.runAction(motions.moveRight(constants.airShipSpeed))
        
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.runBlock({self.idle()}),
            SKAction.waitForDuration(10),
            SKAction.runBlock({self.reach()}),
            SKAction.waitForDuration(0.75),
            SKAction.runBlock({self.clawReach()}),
            SKAction.waitForDuration(2),
            SKAction.runBlock({self.retract()}),
            SKAction.waitForDuration(1)
        ])))
    }
    
    func noshipFishDown() {
        self.playSoundEffect("AIRSHIP_FISH_DOWN")
        self.runAction(motions.playGifForOnce("AIRSHIP_NOSHIP_FISH_DOWN", frames: constants.motionMap["NOSHIP_FISH_DOWN"]!))
    }
    
    func noshipFishUp() {
        self.stopSoundEffect("AIRSHIP_FISH_DOWN")
        self.playSoundEffect("AIRSHIP_FISH_UP")
        self.runAction(motions.playGifForOnce("AIRSHIP_NOSHIP_FISH_UP_" + constants.dotName, frames: constants.motionMap["NOSHIP_FISH_UP"]!))
    }
    
    func noshipFish(dotx: CGFloat) {
        self.runAction(SKAction.sequence([
            SKAction.moveByX(dotx - self.position.x, y: 0, duration: 0.01),
            SKAction.runBlock({self.noshipFishDown()}),
            SKAction.waitForDuration(2.5),
            SKAction.runBlock({self.noshipFishUp()}),
            SKAction.waitForDuration(3), SKAction.fadeOutWithDuration(constants.airShipFadeOutTime)
        ]))
    }
    
    func flyAway() {
        self.playSoundEffect("AIRSHIP_FLY_AWAY")
        self.runAction(motions.playGifFromPNG("AIRSHIP_CLOSED", time: 5))
        self.runAction(motions.moveAway())
    }
    
    func close() {
        self.runAction(motions.playGifForOnce("AIRSHIP_CLOSE", frames: constants.motionMap["CLOSE"]!))
        self.playSoundEffect("AIRSHIP_CLOSE")
    }
    
    func shipFish(dotx: CGFloat) {
        self.playSoundEffect("AIRSHIP_FISH_DOWN")
        self.runAction(SKAction.sequence([
            SKAction.moveByX(dotx - self.position.x - constants.shipDotAlignCorrection, y: 0, duration: 1.0 / constants.airShipGameOverSpeed),
            motions.playGifForOnce("AIRSHIP_REACH", frames: constants.motionMap["REACH"]!),
            motions.playGifForOnce("AIRSHIP_SHIP_FISH_DOWN", frames: constants.motionMap["SHIP_FISH_DOWN"]!),
            motions.playGifForOnce("AIRSHIP_SHIP_FISH_UP_" + constants.dotName, frames: constants.motionMap["SHIP_FISH_UP"]!),
            motions.playGifForOnce("AIRSHIP_CAPTURE_" + constants.dotName, frames: constants.motionMap["CAPTURE"]!),
            SKAction.runBlock({self.close()}),
            SKAction.waitForDuration(3.25),
            SKAction.runBlock({self.flyAway()})
            ]))
    }
    
    func capture() {
        self.runAction(motions.playGifForOnce("AIRSHIP_CAPTURE_" + constants.dotName, frames: constants.motionMap["CAPTURE"]!))
        self.playSoundEffect("AIRSHIP_CAPTURE")
    }
    
    func reach() {
        self.runAction(motions.playGifForOnce("AIRSHIP_REACH", frames: constants.motionMap["REACH"]!))
        self.playSoundEffect("AIRSHIP_REACH")
    }
    
    func clawReach() {
        self.runAction(motions.playGifFromPNG("AIRSHIP_CLAW_REACH", time: 2))
    }
    
    func retract() {
        self.runAction(motions.playGifForOnce("AIRSHIP_RETRACT", frames: constants.motionMap["RETRACT"]!))
        self.playSoundEffect("AIRSHIP_REACH")
    }
    
    func stop() {
        self.removeAllActions()
        self.stopAllSoundEffect()
    }
    
    func playSoundEffect(key: String) {
        var player: RDRAudioPlayer
        if (soundEffects.keys.contains(key)) {
            player = soundEffects[key]!
        } else {
            player = RDRAudioPlayer(filename: key, num: 0)
            player.setVolume(constants.soundVolume)
            soundEffects[key] = player
        }
        player.playMusic()
    }
    
    func stopSoundEffect(key: String) {
        if (soundEffects.keys.contains(key)) {
            let player = soundEffects[key]!
            player.stopMusic()
        }
    }
    
    func stopAllSoundEffect() {
        for player in soundEffects.values {
            player.stopMusic()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
