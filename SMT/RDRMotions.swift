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
}
