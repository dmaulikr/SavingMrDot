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
    var motions = constants.motions
    var isJumping = false
    var soundEffects = [String: RDRAudioPlayer]()
    
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
        self.playSoundEffect("DOT_RUN_LOW_SPEED")
        //self.runAction(motions.playSound("DOT_RUN_LOW_SPEED"), withKey: "run_sound")
        //self.runAction(motions.playSound("DOT_RUN_HIGH_SPEED"))
    }
    
    func jump(ratio: Double) {
        if (!self.isJumping) {
            self.removeAllActions()
            let verticalRatio = sqrt(1 - ratio * ratio)
            self.runAction(motions.moveRight(constants.dotSpeed * ratio + constants.dotHorizonSpeed))
            self.physicsBody?.applyImpulse(CGVectorMake(0, CGFloat(constants.jumpVec * verticalRatio)))
            self.texture = SKTexture(imageNamed: "DOT_" + constants.dotName + "_JUMP")
            let rand = arc4random() % 2 + 1
            self.playSoundEffect("DOT_JUMP_UP_" + String(rand))
            self.isJumping = true
        }
    }
    
    func land() {
        self.removeAllActions()
        self.runAction(motions.playGifForOnce("DOT_" + constants.dotName + "_Jump-down", frames: constants.motionMap["Jump-down"]!, time: 0.25))
        self.playSoundEffect("DOT_JUMP_DOWN")
        self.runRight()
        isJumping = false
    }
    
    func burn() {
        self.playSoundEffect("DOT_FALL")
        self.runAction(SKAction.sequence([
            motions.playGifForOnce("DOT_" + constants.dotName + "_Burn", frames: constants.motionMap["Burn"]!, time: 2.5),
            SKAction.fadeOutWithDuration(constants.dotFadeOutTime)
            ]))
    }
    
    func fall() {
        self.playSoundEffect("DOT_FALL")
        self.runAction(SKAction.sequence([
            motions.playGifForOnce("DOT_" + constants.dotName + "_Fall", frames: constants.motionMap["Fall"]!, time: 2),
            SKAction.fadeOutWithDuration(constants.dotFadeOutTime)
            ]))
    }
    
    func hurt() {
        let rand = arc4random() % 2
        if (rand == 0) {
            self.playSoundEffect("DOT_HURT")
        } else {
            self.playSoundEffect("DOT_HURT_AH")
        }
        self.runAction(SKAction.sequence([
            motions.playGifForOnce("DOT_" + constants.dotName + "_Hurt-before", frames: constants.motionMap["Hurt-before"]!, time: 0.5),
            motions.playGifForOnce("DOT_" + constants.dotName + "_Hurt-after", frames: constants.motionMap["Hurt-after"]!, time: 2.5),
            SKAction.fadeOutWithDuration(constants.dotFadeOutTime)
            ]))
    }
    
    func captured() {
        self.runAction(SKAction.sequence([
            motions.playGifFromPNG("DOT_" + constants.dotName + "_STAND", time: 3),
            SKAction.fadeOutWithDuration(constants.dotFadeOutTime)
            ]))
        self.playSoundEffect("DOT_SCREAM_CAPTURE")
        //self.playSoundEffect("DOT_SCREAM_TANK")
    }
    
    func stop() {
        self.stopAllSoundEffect()
        self.removeAllActions()
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
