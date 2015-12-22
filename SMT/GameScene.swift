//
//  GameScene.swift
//  SMT
//
//  Created by Haoruo Peng on 12/6/15.
//  Copyright (c) 2015 Haoruo Peng. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var isStarted = false
    var isGameOver = false
    
    let GAME_FONT = "Helvetica" // AmericanTypewriter-Bold
    
    let world = SKNode()
    let hero = MLHero()
    let generator = MLWorldGenerator()
    let pointsLabel = MLPointsLabel()
    let highScoreLabel = MLPointsLabel()
    
    let data = GameData()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        //let width = self.frame.size.width
        //let height = width / 16 * 9
        
        //self.backgroundColor = SKColor.colorWithAlphaComponent()
        
        data.dataInit()
        
        self.addChild(world)
            
        generator.setMyWorld(world)
        self.addChild(generator)
        generator.populate()
        
        hero.position = CGPointMake(0, -10)
        world.addChild(hero)
        
        self.loadScoreLabels()
        
        let tapToBeginLabel = SKLabelNode(fontNamed: GAME_FONT)
        tapToBeginLabel.text = "tap to begin"
        tapToBeginLabel.fontSize = 20
        tapToBeginLabel.name = "tapToBeginLabel"
        self.addChild(tapToBeginLabel)
        self.animateWithPulse(tapToBeginLabel)
    }
    
    override func didSimulatePhysics() {
        //let hero = self.childNodeWithName("hero") as! MLHero
        self.centerOnNode(hero)
        self.handlePoints()
        self.handleGeneration()
        self.handleCleanUp()
    }
    
    func loadScoreLabels() {
        pointsLabel.setMyFontName(GAME_FONT)
        pointsLabel.position = CGPointMake(-150, 70)
        pointsLabel.name = "pointsLabel"
        self.addChild(pointsLabel)
        
        data.load()
        highScoreLabel.setMyFontName(GAME_FONT)
        highScoreLabel.setPoints(data.highScore)
        highScoreLabel.position = CGPointMake(150, 70)
        highScoreLabel.name = "highScoreLabel"
        self.addChild(highScoreLabel)
        
        let bestLabel = SKLabelNode(fontNamed: GAME_FONT)
        bestLabel.position = CGPointMake(110, 70)
        bestLabel.text = "Best"
        bestLabel.fontSize = 16
        self.addChild(bestLabel)
    }
    
    func centerOnNode(node: SKNode) {
        let positionInScene = self.convertPoint(node.position, fromNode: node.parent!)
        world.position = CGPointMake(world.position.x - positionInScene.x, world.position.y)
    }
    
    func start() {
        isStarted = true
        self.childNodeWithName("tapToBeginLabel")?.removeFromParent()
        hero.runRight()
    }
    
    func clear() {
        let scene = GameScene.init(size: CGSizeMake(self.frame.size.width, self.frame.size.width / 16 * 9))
        self.view?.presentScene(scene)
    }
    
    func gameOver() {
        self.isGameOver = true
        hero.stop()
        
        //pointsLabel.removeFromParent()
        let gameOverLabel = SKLabelNode(fontNamed: GAME_FONT)
        gameOverLabel.text = "Game Over"
        gameOverLabel.position = CGPointMake(0, 60)
        self.addChild(gameOverLabel)
        
        let tapToResetLabel = SKLabelNode(fontNamed: GAME_FONT)
        tapToResetLabel.text = "tap to reset"
        tapToResetLabel.fontSize = 20
        tapToResetLabel.name = "tapToResetLabel"
        self.addChild(tapToResetLabel)
        self.animateWithPulse(tapToResetLabel)
        self.updateHighScore()
    }
    
    func updateHighScore() {
        let currentPointLabel = self.childNodeWithName("pointsLabel") as! MLPointsLabel
        let highestPointLabel = self.childNodeWithName("highScoreLabel") as! MLPointsLabel
        if (currentPointLabel.number > highestPointLabel.number) {
            highestPointLabel.setPoints(currentPointLabel.number)
            data.highScore = currentPointLabel.number
            data.save()
        }
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
        self.world.enumerateChildNodesWithName("ground") { node, stop in
            if (node.position.x < self.hero.position.x - self.frame.size.width/2 - node.frame.size.width/2) {
                node.removeFromParent()
            }
        }
        self.world.enumerateChildNodesWithName("obstacle_cancelled") { node, stop in
            if (node.position.x < self.hero.position.x - self.frame.size.width/2 - node.frame.size.width/2) {
                node.removeFromParent()
            }
        }
    }
    
    func handlePoints() {
        self.world.enumerateChildNodesWithName("obstacle") { node, stop in
            if (node.position.x < self.hero.position.x) {
                let pl = self.childNodeWithName("pointsLabel") as! MLPointsLabel
                pl.increment()
            }
        }
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
        self.physicsWorld.contactDelegate = self
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if (contact.bodyA.node?.name == "hiddenground" || contact.bodyB.node?.name == "hiddenground") {
            hero.land()
        } else {
            self.gameOver()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func animateWithPulse(node: SKNode) {
        let disappear = SKAction.fadeAlphaTo(0.0, duration: 0.3)
        let appear = SKAction.fadeAlphaTo(1.0, duration: 0.3)
        let pulse = SKAction.sequence([disappear, appear])
        node.runAction(SKAction.repeatActionForever(pulse))
    }
}
