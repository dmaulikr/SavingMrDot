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
            if (currentObstacleX % groundWidth < 30) {
                currentObstacleX += 50
            } else {
                if (currentObstacleX % groundWidth > groundWidth - 30) {
                    currentObstacleX -= 50
                }
            }
            let p = (currentObstacleX - 3 * groundWidth) / (6 * groundWidth)
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
    
    func generate(points: Int) -> SKSpriteNode {
        self.updateGameDN()
        
        let rand = arc4random() % 5
        let obstacle = RDRObstacle(rand: rand, currentObstacleX: currentObstacleX, screenHeight: screenHeight, gameTime: constants.gameDN)
        
        currentObstacleX += CGFloat(computeBaseGap(points)) + CGFloat(arc4random() % 100)
        return obstacle
    }
    
    func computeBaseGap(p: Int) -> Double {
        let k = p / constants.step
        let y2_corrected = constants.y2 - constants.alpha * k
        let y1_corrected = constants.y1 - constants.alpha * k
        let a = Double(y2_corrected - y1_corrected) / (1 - exp(Double(constants.step)))
        let b = Double(y2_corrected) - a
        let x = p % constants.step
        let gap = a * exp(Double(x)) + b
        print("Gap: " + gap.description)
        return gap
    }
}