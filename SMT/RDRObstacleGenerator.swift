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
    var motions = RDRMotions()
    
    var currentObstacleX = CGFloat(0)
    var screenHeight = CGFloat(0)
    var groundWidth = CGFloat(0)
    var threshold = 0
    
    init() {
        currentObstacleX = constants.initObstacleX
    }
    
    func setScreenHeight(h: CGFloat) {
        screenHeight = h
    }
    
    func setGroundWidth(l: CGFloat) {
        groundWidth = l
    }
    
    func updateGameDN() {
        if (currentObstacleX < 3 * groundWidth) {
            constants.gameDN = "day"
        } else {
            var p = (currentObstacleX - 3 * groundWidth) / (6 * groundWidth)
            if (p == CGFloat(threshold)) {
                currentObstacleX += 50
                p = (currentObstacleX - 3 * groundWidth) / (6 * groundWidth)
            }
            if (p > CGFloat(threshold)) {
                if (threshold % 2 == 0) {
                    constants.gameDN = "night"
                } else {
                    constants.gameDN = "day"
                }
                threshold++
            }
        }
    }
    
    func generate() -> SKSpriteNode {
        self.updateGameDN()
        
        let rand = arc4random() % 5
        let obstacle = RDRObstacle(rand: rand, currentObstacleX: currentObstacleX, screenHeight: screenHeight, gameTime: constants.gameDN)
        
        currentObstacleX += 600
        return obstacle
    }    
}