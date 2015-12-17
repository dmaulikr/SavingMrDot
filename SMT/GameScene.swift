//
//  GameScene.swift
//  SMT
//
//  Created by Haoruo Peng on 12/6/15.
//  Copyright (c) 2015 Haoruo Peng. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var isStarted = false
    var isGameOver = false
    
    let world = SKNode()
    let hero = MLHero()
    let generator = MLWorldGenerator()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        //let width = self.frame.size.width
        //let height = width / 16 * 9
        
        self.addChild(world)
            
        generator.setMyWorld(world)
        self.addChild(generator)
        generator.populate()
        
        world.addChild(hero)
        
        
        
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!";
//        myLabel.fontSize = 45;
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
//        self.addChild(myLabel)
    }
    
    override func didSimulatePhysics() {
        //let hero = self.childNodeWithName("hero") as! MLHero
        self.centerOnNode(hero)
        self.handleGeneration()
        self.handleCleanUp()
    }
    
    func centerOnNode(node: SKNode) {
        let positionInScene = self.convertPoint(node.position, fromNode: node.parent!)
        world.position = CGPointMake(world.position.x - positionInScene.x, world.position.y)
    }
    
    func start() {
        isStarted = true
        hero.runRight()
    }
    
    func clear() {
        NSLog("Clear")
    }
    
    func gameOver() {
        NSLog("Over")
    }
    
    func handleGeneration() {
        self.world.enumerateChildNodesWithName("obstacle") { node, stop in
            if (node.position.x < self.hero.position.x) {
                node.name = "obstacle_cancelled"
                self.generator.generate()
            }
        }
    }
    
    func handleCleanUp() {
        
    }
     
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        //let hero = self.childNodeWithName("hero") as! MLHero
        
        if (!isStarted) {
            self.start()
        }
        else {
            if (isGameOver) {
                self.clear()
            }
            else {
                hero.jump()
            }
        }
        
        /*
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
        */
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        self.anchorPoint = CGPointMake(0.5, 0.5)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
