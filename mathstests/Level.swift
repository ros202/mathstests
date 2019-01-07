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
        colour: UIColor,
        availableQuestions: Array<Description>,
        questionCount: Int = 30,
        upperBound: Int
        )
    {
        /// Properties you set with these Parameters
        self.title = title
        self.timeAllowed = timeAllowed
        self.colour = colour
        self.availableQuestions = availableQuestions
        self.questionCount = questionCount
        self.upperBound = upperBound
        
        /// Other Methods you wish to run upon initialisation
        self.questions = makeQuestions(questionTypes: self.availableQuestions)
        
    }
    
    /// Properties which can initialised
    public var title: String = ""
    public var timeAllowed: Int = 0
    public var colour: UIColor = UIColor()
    public var availableQuestions: Array<Description> = []
    public var questionCount: Int = 30
    public var upperBound: Int = 12
    
    /// Other Properties which can be set/modified from outside
    public var questions: Array<QuestionType> = []
    
    /// Instance Methods
    
    /// Makes a list of questions for this level
    func makeQuestions(questionTypes: Array<Description>) -> Array<QuestionType> {
        var questionsToBeReturned: Array<QuestionType> = []
        for _ in 0..<self.questionCount {
            questionsToBeReturned.append(QuestionType(upperBound: self.upperBound, description: questionTypes.randomElement()!))
        }
        return questionsToBeReturned
    }
    
}
