//
//  RDRMotions.swift
//  RunDotRun
//
//  Created by Haoruo Peng on 1/6/16.
//  Copyright © 2016 Haoruo Peng. All rights reserved.
//

import Foundation
import SpriteKit

class RDRMotions {
    func animateWithPulse() -> SKAction {
        let disappear = SKAction.fadeAlphaTo(0.0, duration: 0.3)
        let appear = SKAction.fadeAlphaTo(1.0, duration: 0.3)
        let pulse = SKAction.sequence([disappear, appear])
        return SKAction.repeatActionForever(pulse)
    }
    
    func moveRight(speed: Double) -> SKAction {
        let incrementalRight = SKAction.moveByX(1.0, y: 0, duration: 1.0 / speed)
        return SKAction.repeatActionForever(incrementalRight)
    }
    
    func playGif(fileName: String, frames: Int) -> SKAction {
        var gifTextures: [SKTexture] = []
        for i in 0...frames {
            gifTextures.append(SKTexture(imageNamed: fileName + "-\(i)"))
        }
        return SKAction.repeatActionForever(SKAction.animateWithTextures(gifTextures, timePerFrame: 0.125))
    }
    
    func playGifForOnce(fileName: String, frames: Int) -> SKAction {
        var gifTextures: [SKTexture] = []
        for i in 0...frames {
            gifTextures.append(SKTexture(imageNamed: fileName + "-\(i)"))
        }
        return SKAction.animateWithTextures(gifTextures, timePerFrame: 0.250)
    }
    
/*
    func playSound(fileName: String) -> SKAction {
        return SKAction.playSoundFileNamed("SOUNDS/" + fileName + ".wav", waitForCompletion: false)
    }
*/
}