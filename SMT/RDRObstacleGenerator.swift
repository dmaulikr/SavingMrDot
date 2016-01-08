//
//  RDRObstacleGenerator.swift
//  RunDotRun
//
//  Created by Haoruo Peng on 1/7/16.
//  Copyright © 2016 Haoruo Peng. All rights reserved.
//

import Foundation
import SpriteKit

class RDRObstacleGenerator {
    let constants = RDRConstants()
    
    var currentObstacleX = CGFloat(0)
    var screenHeight = CGFloat(0)
    
    init() {
        currentObstacleX = constants.initObstacleX
    }
    
    func setScreenHeight(h: CGFloat) {
        screenHeight = h
    }
    
    func generate() -> SKSpriteNode {
        let obstacle = SKSpriteNode(color: self.getRandomColor(), size: constants.obstacleSize)
        obstacle.position = CGPointMake(currentObstacleX, -screenHeight/2 + constants.hiddengroundHeight + obstacle.frame.size.height/2)
        obstacle.physicsBody = SKPhysicsBody(rectangleOfSize: obstacle.size)
        obstacle.physicsBody?.categoryBitMask = constants.obstacleCategory
        obstacle.physicsBody?.dynamic = false
        obstacle.name = "obstacle"
        currentObstacleX += 600
        return obstacle
    }
    
    func getRandomColor() -> UIColor {
        let rand = arc4random() % 6
        var color = UIColor()
        switch (rand) {
        case 0:
            color = UIColor.redColor()
            break
        case 1:
            color = UIColor.orangeColor()
            break
        case 2:
            color = UIColor.yellowColor()
            break
        case 3:
            color = UIColor.greenColor()
            break
        case 4:
            color = UIColor.purpleColor()
            break
        case 5:
            color = UIColor.blueColor()
            break
        default:
            break
        }
        return color
    }
}