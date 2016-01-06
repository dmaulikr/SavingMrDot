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
    var currentObstacleX = CGFloat(200)
    var world = SKNode()
    
    override init() {
        super.init()
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
        for _ in 1...3 {
            generate()
        }
    }
    
    func generate() {
        let width = self.scene!.size.width
        let height = width / 16 * 9
        
        let hiddenground = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(width,10))
        hiddenground.position = CGPointMake(currentHiddenGroundX, -height/2 + hiddenground.frame.size.height/2)
        hiddenground.zPosition = -1
        hiddenground.physicsBody = SKPhysicsBody(rectangleOfSize: hiddenground.size)
        hiddenground.physicsBody?.categoryBitMask = constants.groundCategory
        hiddenground.physicsBody?.dynamic = false
        hiddenground.name = "hiddenground"
        world.addChild(hiddenground)
        currentHiddenGroundX += hiddenground.frame.size.width
        
        let background = SKSpriteNode(imageNamed: "background_day")
        background.size.width = height / background.size.height * background.size.width
        background.size.height = height
        background.position = CGPointMake(currentBackGroundX, 0)
        background.zPosition = -0.9
        background.name = "background"
        world.addChild(background)
        currentBackGroundX += background.frame.size.width
        
        let ground = SKSpriteNode(imageNamed: "ground_day")
        ground.size.height = ground.size.height / 2
        ground.size.width = ground.size.width / 2
        ground.position = CGPointMake(currentGroundX, -height/2 + ground.frame.size.height/2)
        ground.zPosition = -0.5
        ground.name = "ground"
        world.addChild(ground)
        currentGroundX += ground.frame.size.width
        
        let obstacle = SKSpriteNode(color: self.getRandomColor(), size: CGSizeMake(20, 40))
        obstacle.position = CGPointMake(currentObstacleX, hiddenground.position.y + hiddenground.frame.size.height/2 + obstacle.frame.size.height/2)
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
