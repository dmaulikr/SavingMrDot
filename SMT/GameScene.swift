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
    
    var threshold = 0
    
    var constants = RDRConstants()
    var motions = RDRMotions()
    let musicPlayer = RDRAudioPlayer(filename: "MUSIC")
    let dayPlayer = RDRAudioPlayer(filename: "BACKGROUND_DAY")
    let nightPlayer = RDRAudioPlayer(filename: "BACKGROUND_NIGHT")
    let data = RDRGameData()
    
    let world = SKNode()
    let dot = RDRDot()
    let ship = RDRAirShip()
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
        
        ship.position = constants.airShipPosition
        world.addChild(ship)
        ship.open()
        
        self.loadScoreLabels()
        
        self.loadTapToBeginLabel()
        
        musicPlayer.setVolume(constants.musicVolume)
        dayPlayer.setVolume(constants.backgroundVolume)
        nightPlayer.setVolume(constants.backgroundVolume)
        musicPlayer.playMusic()
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
        self.handleBackgroundMusic()
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
                self.generator.generateObstacle()
            }
        }
        if (self.dot.position.x > generator.currentGroundX - self.frame.width * 3) {
            self.generator.generateForeBackGround()
        }
        if (self.dot.position.x > generator.currentHiddenGroundX - self.frame.width * 3) {
            self.generator.generateHiddenGround()
        }
    }
    
    func handleCleanUp() {
        self.world.enumerateChildNodesWithName("ground") { node, stop in
            if (node.position.x < self.dot.position.x - self.frame.size.width/2 - node.frame.size.width/2) {
                node.removeFromParent()
            }
        }
        self.world.enumerateChildNodesWithName("background") { node, stop in
            if (node.position.x < self.dot.position.x - self.frame.size.width/2 - node.frame.size.width/2) {
                node.removeFromParent()
            }
        }
        self.world.enumerateChildNodesWithName("hiddenground") { node, stop in
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
    
    func handleBackgroundMusic() {
        let dist = dot.position.x
        var length = CGFloat(0)
        self.world.enumerateChildNodesWithName("background") { node, stop in
            length = node.frame.size.width
        }
        if (dist < 3 * length) {
            dayPlayer.playMusic()
        } else {
            let p = (dist - 3 * length) / (6 * length)
            if (p > CGFloat(threshold)) {
                if (threshold % 2 == 0) {
                    dayPlayer.pauseMusic()
                    nightPlayer.playMusic()
                } else {
                    nightPlayer.pauseMusic()
                    dayPlayer.playMusic()
                }
                threshold++
                
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
        ship.moveRight()
    }
    
    func clear() {
        let scene = GameScene.init(size: CGSizeMake(self.frame.size.width, self.frame.size.width / 16 * 9))
        self.view?.presentScene(scene)
    }
    
    func gameOver() {
        self.isGameOver = true
        
        dot.stop()
        ship.stop()
        self.removeAllActions()
        
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
        
        musicPlayer.stopMusic()
        dayPlayer.stopMusic()
        nightPlayer.stopMusic()
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
            if (contact.bodyA.node?.name == "airship" || contact.bodyB.node?.name == "airship") {
                
            } else {
                self.gameOver()
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
