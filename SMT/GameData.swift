//
//  GameData.swift
//  SMT
//
//  Created by Haoruo Peng on 12/22/15.
//  Copyright © 2015 Haoruo Peng. All rights reserved.
//

import Foundation

class GameData {
    var filePath = ""
    var fileName = "/achive.data"
    var highScore = 0
    
    func dataInit() {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        filePath = path.stringByAppendingString(fileName)
        if (!NSFileManager.defaultManager().fileExistsAtPath(filePath)) {
            self.save()
        }
    }
    
    func save() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(highScore)
        data.writeToFile(filePath, atomically: true)
    }
    
    func load() {
        let data = NSData(contentsOfFile: filePath)
        highScore = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! Int
    }
}
