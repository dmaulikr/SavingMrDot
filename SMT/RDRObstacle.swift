//
//  RDRObstacle.swift
//  RunDotRun
//
//  Created by Haoruo Peng on 1/13/16.
//  Copyright © 2016 Haoruo Peng. All rights reserved.
//

import UIKit
import SpriteKit

class RDRObstacle: SKSpriteNode {
    var motions = RDRMotions()
    
    var imageName = ""
    var obSize = CGSizeMake(0, 0)
    var heightOffset = CGFloat(0)
    var phSize = CGSizeMake(0, 0)
    var labelName = ""
    
    var gameDN = "day"
    
    init(rand: UInt32, currentObstacleX: CGFloat, screenHeight: CGFloat, gameTime: String) {
        gameDN = gameTime
        
        switch (rand) {
        case 0:
            imageName = "HOLE_"
            obSize = constants.holeSize
            heightOffset = -10
            break
        case 1:
            imageName = "ROCK_BIG_"
            obSize = constants.rockBigSize
            heightOffset = -5
            break
        case 2:
            imageName = "ROCK_MEDIUM_"
            obSize = constants.rockMediumSize
            heightOffset = -5
            break
        case 3:
            imageName = "ROCK_SMALL_"
            obSize = constants.rockSmallSize
            heightOffset = -5
            break
        case 4:
            imageName = "FIRE_REST_"
            obSize = constants.fireSize
            heightOffset = -5
            break
        default:
            break
        }
        
        let texture = SKTexture(imageNamed: imageName + gameDN.uppercaseString)
        super.init(texture: texture, color: UIColor.whiteColor().colorWithAlphaComponent(0.5), size: obSize)
        self.position = CGPointMake(currentObstacleX, -screenHeight/2 + constants.hiddengroundHeight + self.frame.size.height/2 + heightOffset)
        
        switch (rand) {
        case 0:
            phSize = CGSizeMake(self.size.width * constants.holePhysicsBodyWidthRatio, 1)
            labelName = "obstacle_hole"
            break
        case 1:
            phSize = CGSizeMake(self.size.width * constants.rockBigPhysicsBodyWidthRatio, self.size.height * constants.rockBigPhysicsBodyHeightRatio)
            labelName = "obstacle_rock"
            break
        case 2:
            phSize = CGSizeMake(self.size.width * constants.rockMediumPhysicsBodyWidthRatio, self.size.height * constants.rockMediumPhysicsBodyHeightRatio)
            labelName = "obstacle_rock"
            break
        case 3:
            phSize = CGSizeMake(self.size.width * constants.rockSmallPhysicsBodyWidthRatio, self.size.height * constants.rockSmallPhysicsBodyHeightRatio)
            labelName = "obstacle_rock"
            break
        case 4:
            phSize = CGSizeMake(self.size.width * constants.firePhysicsBodyWidthRatio, self.size.height * constants.firePhysicsBodyHeightRatio)
            labelName = "obstacle_fire"
            break
        default:
            break
        }

        self.physicsBody = SKPhysicsBody(rectangleOfSize: phSize)
        self.physicsBody?.categoryBitMask = constants.obstacleCategory
        self.physicsBody?.dynamic = false
        self.name = labelName
    }
    
    func startFire() {
        self.runAction(SKAction.sequence(
            [motions.playGifForOnce("FIRE_" + gameDN.uppercaseString + "_BEGIN", frames: constants.motionMap["FIRE-BEGIN"]!),
             motions.playGifForOnce("FIRE_" + gameDN.uppercaseString + "_DURING", frames: constants.motionMap["FIRE-DURING"]!),
             motions.playGifForOnce("FIRE_" + gameDN.uppercaseString + "_END", frames: constants.motionMap["FIRE-END"]!) ]))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
