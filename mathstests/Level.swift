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
    
    /// Ways of creating an instance of Level
    init() {}
    init(
        /// Optional/required Parameters for this initialisation
        title: String,
        timeAllowed: Int = 45, /// Default property value is 45; can be optionally set otherwise
        colour: UIColor
        )
    {
        /// Properties you set with these Parameters
        self.title = title
        self.timeAllowed = timeAllowed
        self.colour = colour
    }
    
    /// Properties which can initialised
    public var title: String = ""
    public var timeAllowed: Int = 0
    public var colour: UIColor = UIColor()
    
    /// Other Properties which can be set/modified from outside
    
    /// Instance Methods
    
    
}
