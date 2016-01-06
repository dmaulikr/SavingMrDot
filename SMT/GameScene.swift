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
    
    var constants = RDRConstants()
    let data = RDRGameData()
    let motions = RDRMotions()
    
    let world = SKNode()
    let dot = RDRDot()
    let generator = RDRWorldGenerator()
    let pointsLabel = RDRPointsLabel()
    let highScoreLabel = RDRPointsLabel()
    
    override init(size: CGSize) {
        super.init(size: size)
        self.anchorPoint = CGPointMake(0.5, 0.5)
        self.physicsWorld.contactDelegate = self
    }
    
    override func didMoveToView(view: SKView) {
        data.dataInit()
        
        self.addChild(world)
        generator.setMyWorld(world)
        self.addChild(generator)
        generator.populate()
        
        dot.position = constants.dotPosition
        world.addChild(dot)
        
        self.loadScoreLabels()
        
        self.loadTapToBeginLabel()
    }
    
    func loadScoreLabels() {
        pointsLabel.setMyFontName(constants.gameFont)
        pointsLabel.position = constants.pointPosition
        pointsLabel.name = "pointsLabel"
        self.addChild(pointsLabel)
        
        data.load()
        
        let bestLabel = SKLabelNode(fontNamed: constants.gameFont)
        bestLabel.position = CGPointMake(110, 70)
        bestLabel.text = "Best"
        bestLabel.fontSize = 16
        self.addChild(bestLabel)
        
        highScoreLabel.setMyFontName(constants.gameFont)
        highScoreLabel.setPoints(data.highScore)
        highScoreLabel.position = CGPointMake(150, 70)
        highScoreLabel.name = "highScoreLabel"
        self.addChild(highScoreLabel)
    }
    
    func loadTapToBeginLabel() {
        let tapToBeginLabel = SKLabelNode(fontNamed: constants.gameFont)
        tapToBeginLabel.text = "tap to begin"
        tapToBeginLabel.fontSize = constants.textSize
        tapToBeginLabel.name = "tapToBeginLabel"
        self.addChild(tapToBeginLabel)
        tapToBeginLabel.runAction(motions.animateWithPulse())
    }

    override func didSimulatePhysics() {
        self.centerOnNode(dot)
        self.handlePoints()
        self.handleGeneration()
        self.handleCleanUp()
    }
    
    func centerOnNode(node: SKNode) {
        let positionInScene = self.convertPoint(node.position, fromNode: node.parent!)
        world.position = CGPointMake(world.position.x - positionInScene.x, world.position.y)
    }

    func handlePoints() {
        self.world.enumerateChildNodesWithName("obstacle") { node, stop in
            if (node.position.x < self.dot.position.x) {
                let pl = self.childNodeWithName("pointsLabel") as! RDRPointsLabel
                pl.increment()
            }
        }
    }
    
    func handleGeneration() {
        self.world.enumerateChildNodesWithName("obstacle") { node, stop in
            if (node.position.x < self.dot.position.x) {
                node.name = "obstacle_cancelled"
                self.generator.generate()
            }
        }
    }
    
    func handleCleanUp() {
        self.world.enumerateChildNodesWithName("ground") { node, stop in
            if (node.position.x < self.dot.position.x - self.frame.size.width/2 - node.frame.size.width/2) {
                node.removeFromParent()
            }
        }
        self.world.enumerateChildNodesWithName("obstacle_cancelled") { node, stop in
            if (node.position.x < self.dot.position.x - self.frame.size.width/2 - node.frame.size.width/2) {
                node.removeFromParent()
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (!isStarted) {
            self.start()
        }
        else {
            if (isGameOver) {
                self.clear()
            }
            else {
                dot.jump()
            }
        }
    }
    
    func start() {
        isStarted = true
        self.childNodeWithName("tapToBeginLabel")?.removeFromParent()
        dot.runRight()
    }
    
    func clear() {
        let scene = GameScene.init(size: CGSizeMake(self.frame.size.width, self.frame.size.width / 16 * 9))
        self.view?.presentScene(scene)
    }
    
    func gameOver() {
        self.isGameOver = true
        
        dot.stop()
        
        let gameOverLabel = SKLabelNode(fontNamed: constants.gameFont)
        gameOverLabel.text = "Game Over"
        gameOverLabel.position = CGPointMake(0, 60)
        self.addChild(gameOverLabel)
        
        let tapToResetLabel = SKLabelNode(fontNamed: constants.gameFont)
        tapToResetLabel.text = "tap to reset"
        tapToResetLabel.fontSize = 20
        tapToResetLabel.name = "tapToResetLabel"
        self.addChild(tapToResetLabel)
        tapToResetLabel.runAction(motions.animateWithPulse())
        
        self.updateHighScore()
    }
    
    func updateHighScore() {
        let currentPointLabel = self.childNodeWithName("pointsLabel") as! RDRPointsLabel
        let highestPointLabel = self.childNodeWithName("highScoreLabel") as! RDRPointsLabel
        if (currentPointLabel.number > highestPointLabel.number) {
            highestPointLabel.setPoints(currentPointLabel.number)
            data.highScore = currentPointLabel.number
            data.save()
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if (contact.bodyA.node?.name == "hiddenground" || contact.bodyB.node?.name == "hiddenground") {
            dot.land()
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
}
