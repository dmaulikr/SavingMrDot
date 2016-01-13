//
//  RDRGameTouchHandler.swift
//  RunDotRun
//
//  Created by Haoruo Peng on 1/7/16.
//  Copyright © 2016 Haoruo Peng. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class RDRGameTouchHandler {
    var touches: Array<RDRGameTouch> = []
    
    func addTouch(touch: RDRGameTouch) {
        touches.append(touch)
    }
    
    func computeLine(touch: RDRGameTouch) -> Double {
        touches.append(touch)
        for t in touches {
            if (touch.time - t.time > 0.5) {
                touches.removeAtIndex(touches.indexOf(t)!)
            }
        }
        let n = Double(touches.count)
        if (n < 2) {
            touches.removeAll()
            return 1
        }
        
        var a = Double(0), b = Double(0), c = Double(0), d = Double(0)
        for t in touches {
            let location = t.location
            a += Double(location.x)
            b += Double(location.y)
            c += Double(location.x * location.x)
            d += Double(location.x * location.y)
        }
        if (n * c - a * a == 0) {
            return 1
        }
        let slope = (n * d - a * b) / (n * c - a * a)
        let ratio = 1 / (1 + slope * slope)
        return ratio
    }
}
