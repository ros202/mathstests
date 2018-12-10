//
//  QuestionType.swift
//  mathstests
//
//  Created by Ross Harrison on 03/12/18.
//  Copyright © 2018 Ross Harrison. All rights reserved.
//

import Foundation

enum Description {
    case SimpleTimes
    case SimpleDivide
}

class QuestionType {
    init(
        lowerBound: Int = 0,
        upperBound: Int,
        description: Description
        ) {
        self.interval = lowerBound...upperBound
        self.description = description
        setupQuestion()
    }
    
    /// Initialised properties
    var interval: ClosedRange<Int>
    var description: Description
    
    /// Other properties
    var questionText: String = ""
    var correctAnswer: Int = 0
    
    func setupQuestion() {
        switch self.description {
        case .SimpleTimes:
            let calc1 = Int.random(in: interval)
            let calc2 = Int.random(in: interval)
            self.correctAnswer = calc1 * calc2
            let operand1 = String(calc1)
            let operand2 = String(calc2)
            let operand3 = "?"
            let operator1 = "×"
            let operator2 = "="
            self.questionText = "\(operand1) \(operator1) \(operand2) \(operator2) \(operand3)"
        case .SimpleDivide:
            let calc1 = Int.random(in: interval)
            let calc2 = Int.random(in: interval)
            self.correctAnswer = calc1
            let operand1 = String(calc1*calc2)
            let operand2 = String(calc2)
            let operand3 = "?"
            let operator1 = "÷"
            let operator2 = "="
            self.questionText = "\(operand1) \(operator1) \(operand2) \(operator2) \(operand3)"
        }
    }
}
