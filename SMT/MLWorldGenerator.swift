//
//  MLWorldGenerator.swift
//  SMT
//
//  Created by Haoruo Peng on 12/16/15.
//  Copyright © 2015 Haoruo Peng. All rights reserved.
//

import UIKit
import SpriteKit

class MLWorldGenerator: SKNode {
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
        let ground = SKSpriteNode(color: UIColor.greenColor(), size: CGSizeMake(width, 50))
        ground.position = CGPointMake(currentGroundX, -height/2 + ground.frame.size.height/2)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: ground.size)
        ground.physicsBody?.dynamic = false
        ground.name = "ground"
        world.addChild(ground)
        currentGroundX += ground.frame.size.width
        
        let obstacle = SKSpriteNode(color: self.getRandomColor(), size: CGSizeMake(20, 70))
        obstacle.position = CGPointMake(currentObstacleX, ground.position.y + ground.frame.size.height/2 + obstacle.frame.size.height/2)
        obstacle.physicsBody = SKPhysicsBody(rectangleOfSize: obstacle.size)
        obstacle.physicsBody?.dynamic = false
        obstacle.name = "obstacle"
        world.addChild(obstacle)
        currentObstacleX += 150
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
