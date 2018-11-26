//
//  Level.swift
//  mathstests
//
//  Created by Ross Harrison on 26/11/18.
//  Copyright © 2018 Ross Harrison. All rights reserved.
//

import Foundation
import UIKit

class Level {
    init() {}
    init(title: String, timeAllowed: Int = 45, colour: UIColor) {
        self.title = title
        self.timeAllowed = timeAllowed
        self.colour = colour
    }
    
    // Properties which can initialised
    public var title: String = ""
    public var timeAllowed: Int = 0
    public var colour: UIColor = UIColor()
}
