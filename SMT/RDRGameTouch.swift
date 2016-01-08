//
//  RDRGameTouch.swift
//  RunDotRun
//
//  Created by Haoruo Peng on 1/7/16.
//  Copyright © 2016 Haoruo Peng. All rights reserved.
//

import Foundation
import SpriteKit

class RDRGameTouch: Equatable {
    var location: CGPoint
    var time: NSTimeInterval
    
    init(loc: CGPoint, t: NSTimeInterval) {
        location = loc
        time = t
    }
}

func ==(lhs: RDRGameTouch, rhs: RDRGameTouch) -> Bool {
    return lhs.time == rhs.time
}