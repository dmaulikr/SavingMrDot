//
//  GameScene.swift
//  SMT
//
//  Created by Haoruo Peng on 12/6/15.
//  Copyright (c) 2015 Haoruo Peng. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var viewController: GameViewController!
    
    var isStarted = false
    var isGameOver = false
    
    var threshold = 0
    
    let motions = constants.motions
    let dayPlayer = constants.dayPlayer
    let nightPlayer = constants.nightPlayer
    let touchHandler = constants.touchHandler
    let data = constants.data
    
    let world = SKNode()
    let dot = RDRDot()
    let ship = RDRAirShip()
    let generator = RDRWorldGenerator()
    let pointsLabel = RDRPointsLabel()
    let highScoreLabel = RDRPointsLabel()
    let tapToResume = SKLabelNode(fontNamed: constants.gameFont)
    
    override init(size: CGSize) {
        super.init(size: size)
        self.anchorPoint = CGPointMake(0.5, 0.5)
        self.physicsWorld.contactDelegate = self
    }
    
    override func didMoveToView(view: SKView) {
        constants.update(self.frame.height, height: self.frame.width)
        
        tapToResume.text = "tap to resume"
        tapToResume.fontSize = constants.textSize
        tapToResume.fontColor = constants.textColor
        tapToResume.position = CGPoint(x: frame.midX, y: frame.midY)
        tapToResume.hidden = true
        tapToResume.name = "tapToResumeLabel"
        self.addChild(tapToResume)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("pauseGameScene"), name: "pauseGameScene", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("showPauseText"), name: "showPauseText", object: nil)
        
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
        
        dayPlayer.setVolume(constants.backgroundVolume)
        nightPlayer.setVolume(constants.backgroundVolume)
        
        if (!constants.musicPlayer.player.playing) {
            constants.musicPlayer.player.play()
        }
    }
    
    func pauseGameScene() {
        print("pause game")
        //self.view?.paused = true
        self.physicsWorld.speed = 0.0
        self.speed = 0.0
    }
    
    func showPauseText() {
        if self.physicsWorld.speed == 0.0 {
            tapToResume.hidden = false
        }
    }
    
    func loadScoreLabels() {
        pointsLabel.setMyFontName(constants.gameFont)
        pointsLabel.position = constants.pointPosition
        pointsLabel.name = "pointsLabel"
        self.addChild(pointsLabel)
        
        data.load()
        
        let bestLabel = SKLabelNode(fontNamed: constants.gameFont)
        bestLabel.position = constants.bestPointLabelPosition
        bestLabel.text = "Best"
        bestLabel.fontSize = 16
        bestLabel.fontColor = constants.textColor
        self.addChild(bestLabel)
        
        highScoreLabel.setMyFontName(constants.gameFont)
        highScoreLabel.setPoints(data.highScore)
        highScoreLabel.position = constants.bestPointPosition
        highScoreLabel.name = "highScoreLabel"
        self.addChild(highScoreLabel)
    }
    
    func loadTapToBeginLabel() {
        let tapToBeginLabel = SKLabelNode(fontNamed: constants.gameFont)
        tapToBeginLabel.text = "tap to begin"
        tapToBeginLabel.fontSize = constants.textSize
        tapToBeginLabel.fontColor = constants.textColor
        tapToBeginLabel.name = "tapToBeginLabel"
        self.addChild(tapToBeginLabel)
        tapToBeginLabel.runAction(motions.animateWithPulse())
    }

    override func didSimulatePhysics() {
        if (isGameOver) {
            return
        }
        self.centerOnNode(dot)
        self.handlePoints()
        self.handleGeneration()
        self.handleCleanUp()
        self.handleBackgroundMusic()
        self.handleObstacleFire()
    }
    
    func centerOnNode(node: SKNode) {
        let positionInScene = self.convertPoint(node.position, fromNode: node.parent!)
        world.position = CGPointMake(world.position.x - positionInScene.x, world.position.y)
    }

    func handlePoints() {
        self.world.enumerateChildNodesWithName("obstacle_hole") { node, stop in
            if (node.position.x < self.dot.position.x) {
                node.name = "obstacle_hole_passed"
                let pl = self.childNodeWithName("pointsLabel") as! RDRPointsLabel
                pl.increment()
            }
        }
        self.world.enumerateChildNodesWithName("obstacle_rock") { node, stop in
            if (node.position.x < self.dot.position.x) {
                node.name = "obstacle_rock_passed"
                let pl = self.childNodeWithName("pointsLabel") as! RDRPointsLabel
                pl.increment()
            }
        }
        self.world.enumerateChildNodesWithName("obstacle_firing") { node, stop in
            if (node.position.x < self.dot.position.x) {
                node.name = "obstacle_fire_passed"
                let pl = self.childNodeWithName("pointsLabel") as! RDRPointsLabel
                pl.increment()
            }
        }
    }
    
    func handleGeneration() {
        if (isGameOver) {
            return
        }
        self.world.enumerateChildNodesWithName("obstacle_hole_passed") { node, stop in
            if (node.position.x < self.dot.position.x - self.frame.width) {
                node.name = "obstacle_cancelled"
                let pl = self.childNodeWithName("pointsLabel") as! RDRPointsLabel
                self.generator.generateObstacle(pl.getPoints())
            }
        }
        self.world.enumerateChildNodesWithName("obstacle_rock_passed") { node, stop in
            if (node.position.x < self.dot.position.x - self.frame.width) {
                node.name = "obstacle_cancelled"
                let pl = self.childNodeWithName("pointsLabel") as! RDRPointsLabel
                self.generator.generateObstacle(pl.getPoints())
            }
        }
        self.world.enumerateChildNodesWithName("obstacle_fire_passed") { node, stop in
            if (node.position.x < self.dot.position.x - self.frame.width) {
                node.name = "obstacle_cancelled"
                let pl = self.childNodeWithName("pointsLabel") as! RDRPointsLabel
                self.generator.generateObstacle(pl.getPoints())
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
        if (isGameOver) {
            return
        }
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
        if (isGameOver) {
            return
        }
        let dist = dot.position.x
        var length = CGFloat(0)
        self.world.enumerateChildNodesWithName("background") { node, stop in
            length = node.frame.size.width
        }
        if (dist < 3 * length) {
            dayPlayer.playMusic()
        } else {
            let p = (dist - 3 * length) / (4 * length)
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
    
    func handleObstacleFire() {
        if (isGameOver) {
            return
        }
        self.world.enumerateChildNodesWithName("obstacle_fire") { node, stop in
            if (node.position.x < self.dot.position.x + self.frame.width) {
                let obstacleFire = node as! RDRObstacle
                obstacleFire.startFire()
                node.name = "obstacle_firing"
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if self.physicsWorld.speed == 0.0 {
            self.physicsWorld.speed = 1.0
            self.speed = 1.0
            if tapToResume.hidden == false {
                tapToResume.hidden = true
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let t = RDRGameTouch(loc: touch.locationInNode(self), t: touch.timestamp)
            touchHandler.addTouch(t)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (!isStarted) {
            self.start()
        }
        else {
            if (isGameOver) {
                self.clear()
            }
            else {
                for touch in touches {
                    let t = RDRGameTouch(loc: touch.locationInNode(self), t: touch.timestamp)
                    let jumpRatio = touchHandler.computeLine(t)
                    print("Ratio" + jumpRatio.description)
                    if (jumpRatio != 1) {
                        dot.jump(jumpRatio)
                    }
                }
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
        self.updateHighScore()
        constants.musicPlayer.stopMusic()
        dayPlayer.stopMusic()
        nightPlayer.stopMusic()
        dot.stop()
        ship.stop()
        self.removeAllChildren()
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("GameOverMenu") as! RDRMenuViewController
        self.viewController.presentViewController(nextViewController, animated:true, completion:nil)
    }
    
    func gameOver() {
        self.isGameOver = true
        
        let gameOverLabel = SKLabelNode(fontNamed: constants.gameFont)
        gameOverLabel.text = "Game Over"
        gameOverLabel.position = CGPointMake(0, 60)
        gameOverLabel.fontColor = constants.textColor
        self.addChild(gameOverLabel)
        
        let tapToResetLabel = SKLabelNode(fontNamed: constants.gameFont)
        tapToResetLabel.text = "tap to reset"
        tapToResetLabel.fontSize = constants.textSize
        tapToResetLabel.fontColor = constants.textColor
        tapToResetLabel.name = "tapToResetLabel"
        self.addChild(tapToResetLabel)
        tapToResetLabel.runAction(motions.animateWithPulse())
        
        self.updateHighScore()
        
        constants.musicPlayer.stopMusic()
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
        if (isGameOver) {
            return
        }
        
        if (contact.bodyA.node?.name == "hiddenground" || contact.bodyB.node?.name == "hiddenground") {
            if (dot.isJumping) {
                dot.land()
            }
        } else {
            if (contact.bodyA.node?.name == "airship" || contact.bodyB.node?.name == "airship") {
                if (contact.bodyA.node?.name == "dot" || contact.bodyB.node?.name == "dot") {
                    dot.stop()
                    ship.stop()
                    self.removeAllActions()
                    
                    world.runAction(SKAction.sequence([
                        SKAction.runBlock({self.ship.shipFish(self.dot.position.x)}),
                        SKAction.waitForDuration(4),
                        SKAction.runBlock({self.dot.captured()}),
                    ]))
                    self.gameOver()
                }
                
            } else {
                if (contact.bodyA.node?.name == "dot" || contact.bodyB.node?.name == "dot") {
                    dot.stop()
                    ship.stop()
                    self.removeAllActions()
                    
                    var obstacleType = ""
                    if (contact.bodyA.node?.name == "obstacle_hole" || contact.bodyB.node?.name == "obstacle_hole" || contact.bodyA.node?.name == "obstacle_hole_passed" || contact.bodyB.node?.name == "obstacle_hole_passed") {
                        obstacleType = "hole"
                    }
                    if (contact.bodyA.node?.name == "obstacle_rock" || contact.bodyB.node?.name == "obstacle_rock" || contact.bodyA.node?.name == "obstacle_rock_passed" || contact.bodyB.node?.name == "obstacle_rock_passed") {
                        obstacleType = "rock"
                    }
                    if (contact.bodyA.node?.name == "obstacle_firing" || contact.bodyB.node?.name == "obstacle_firing" || contact.bodyA.node?.name == "obstacle_fire_passed" || contact.bodyB.node?.name == "obstacle_fire_passed") {
                        obstacleType = "fire"
                    }
                    
                    obstacleCollisionAnimation(obstacleType, isShipIn: self.isAirShipInScene())
                    self.gameOver()
                }
            }
        }
    }
    
    func obstacleCollisionAnimation(type: String, isShipIn: Bool) {
        var dotAction: SKAction
        dotAction = SKAction.init()
        if (type == "hole") {
            dotAction = SKAction.runBlock({self.dot.fall()})
        }
        if (type == "rock") {
            dotAction = SKAction.runBlock({self.dot.hurt()})
        }
        if (type == "fire") {
            dotAction = SKAction.runBlock({self.dot.burn()})
        }
        
        print(isShipIn)
        var shipAction: SKAction
        if (isShipIn) {
            shipAction = SKAction.runBlock({self.ship.shipFish(self.dot.position.x)})
        } else {
            shipAction = SKAction.runBlock({self.ship.noshipFish(self.dot.position.x)})
        }
        
        let timeGap = constants.timeGapMap[[type, isShipIn]]

        world.runAction(SKAction.sequence([
            dotAction,
            SKAction.waitForDuration(timeGap!),
            shipAction
            ]))
    }
    
    func isAirShipInScene() -> Bool {
        if (ship.position.x + constants.shipInSceneCorrection < dot.position.x) {
            return false
        } else {
            return true
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
