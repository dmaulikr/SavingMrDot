//
//  MLWorldGenerator.swift
//  SMT
//
//  Created by Haoruo Peng on 12/16/15.
//  Copyright © 2015 Haoruo Peng. All rights reserved.
//

import UIKit
import SpriteKit

class RDRWorldGenerator: SKNode {
    var constants = RDRConstants()
    
    var currentHiddenGroundX = CGFloat(0)
    var currentBackGroundX = CGFloat(0)
    var currentGroundX = CGFloat(0)
    var currentObstacleX = CGFloat(0)
    var world = SKNode()
    
    var width = CGFloat(0)
    var height = CGFloat(0)
    
    var count = 0
    
    override init() {
        super.init()
        currentObstacleX = constants.initObstacleX
    }
    
    func setMyWorld(w: SKNode) {
        world = w
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
    
    func populate() {
        width = self.scene!.size.width
        height = width / 16 * 9

        for _ in 1...3 {
            generateHiddenGround()
            generateForeBackGround()
            generateObstacle()
        }
    }
    
    func generateHiddenGround() {
        let hiddenground = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(width,constants.hiddengroundHeight))
        hiddenground.position = CGPointMake(currentHiddenGroundX, -height/2 + hiddenground.frame.size.height/2)
        hiddenground.zPosition = constants.hiddengroundZPosition
        hiddenground.physicsBody = SKPhysicsBody(rectangleOfSize: hiddenground.size)
        hiddenground.physicsBody?.categoryBitMask = constants.groundCategory
        hiddenground.physicsBody?.dynamic = false
        hiddenground.name = "hiddenground"
        world.addChild(hiddenground)
        currentHiddenGroundX += hiddenground.frame.size.width
    }
    
    func generateForeBackGround() {
        if (count == 2) {
            count = 0
            if (constants.gameDN == "day") {
                constants.gameDN = "night"
            } else {
                constants.gameDN = "day"
            }
        } else {
            count++
        }
        
        var length = CGFloat(0)
        for _ in 1...2 {
            let background = SKSpriteNode(imageNamed: "background_" + constants.gameDN)
            background.size.width = height / background.size.height * background.size.width
            background.size.height = height
            background.position = CGPointMake(currentBackGroundX - background.size.width/2, 0)
            background.zPosition = constants.backgroundZPosition
            background.name = "background"
            world.addChild(background)
            currentBackGroundX += background.frame.size.width
            
            length = background.size.width * 2
        }
        
        let ground = SKSpriteNode(imageNamed: "ground_" + constants.gameDN)
        ground.size.height = length / ground.size.width * ground.size.height
        ground.size.width = length
        ground.position = CGPointMake(currentGroundX, -height/2 + ground.frame.size.height/2)
        ground.zPosition = constants.groundZPosition
        ground.name = "ground"
        world.addChild(ground)
        currentGroundX += ground.frame.size.width
        
        print(currentGroundX)
        print(currentBackGroundX)
    }
    
    func generateObstacle() {
        let obstacle = SKSpriteNode(color: self.getRandomColor(), size: constants.obstacleSize)
        obstacle.position = CGPointMake(currentObstacleX, -height/2 + constants.hiddengroundHeight + obstacle.frame.size.height/2)
        obstacle.physicsBody = SKPhysicsBody(rectangleOfSize: obstacle.size)
        obstacle.physicsBody?.categoryBitMask = constants.obstacleCategory
        obstacle.physicsBody?.dynamic = false
        obstacle.name = "obstacle"
        world.addChild(obstacle)
        currentObstacleX += 150
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
