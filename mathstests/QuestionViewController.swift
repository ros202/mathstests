//
//  QuestionViewController.swift
//  mathstests
//
//  Created by Ross Harrison on 07/08/18.
//  Copyright © 2018 Ross Harrison. All rights reserved.
//

import UIKit
import Foundation

class QuestionViewController: UIViewController, UITextFieldDelegate, KeyboardDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.difficultyLabel.text = difficultyStringFromSegue
        self.difficultyLabel.textColor = difficultyColourFromSegue
    }
    
    private var score: Int = 0
    private var seconds = 60
    private var timer = Timer()
    private var isTimerRunning = false
    private var questionNumber: Int = 1
    private var correctAnswer: Int = 0
    var difficultyStringFromSegue: String = ""
    var difficultyColourFromSegue: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var questionNumberLabel: UILabel!
    @IBOutlet var answerField: UITextField!
    @IBOutlet var difficultyLabel: UILabel!
 
    
    @IBAction func confirmExit() {
        if isTimerRunning {
            let title = "Close?"
            let message = "Are you sure you want to close?"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Yes", style: .default, handler: {
                action in self.close() /*maybe do something else later when we make a new thing*/
            })
            let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            alert.addAction(yesAction)
            alert.addAction(noAction)
            present(alert, animated: true, completion: nil)
        } else {
            close()
        }
    }
    
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startButtonTapped() {
        if !self.isTimerRunning {
            score = 0
            scoreLabel.text = "Score: \(score)"
            self.questionNumber = 1
            questionNumberLabel.text = "Question: \(questionNumber)"
            answerField.becomeFirstResponder() 
            runTimer()
            generateNewQuestion()
            
            let keyboardView = KeyboardViewController()
            keyboardView.delegate = self  // the vc will be notified by the keyboard whenever a key is tapped
            answerField.inputView = keyboardView
        }
    }
    
    @IBAction func answerTyped(_ textField: UITextField) {
        let givenAnswer = textField.text
        if markAnswer(answer: givenAnswer ?? "") {
            self.score += 1
            scoreLabel.text = "Score: \(score)"
        }
        self.questionNumber += 1
        questionNumberLabel.text = "Question: \(questionNumber)"
        generateNewQuestion()
        textField.text = ""
    }

    func generateNewQuestion(){
        var calc1: Int
        var calc2: Int
        var operand1: String
        var operand2: String
        var operand3: Character
        var operator1: String
        var operator2: String
        var questionType: String
        let questionTypeArray: Array<String> = ["×", "÷"]

        switch difficultyStringFromSegue {
        case "Underling":
            calc1 = Int.random(in: 0...12)
            calc2 = Int.random(in: 0...12)
            correctAnswer = calc1 * calc2
            operand1 = String(calc1)
            operand2 = String(calc2)
            operand3 = "?"
            operator1 = "×"
            operator2 = "="

        case "Intermediate":
            questionType = questionTypeArray[0...1].randomElement()!
            calc1 = Int.random(in: 0...13)
            calc2 = Int.random(in: 0...13)
            operand3 = "?"
            operator1 = questionType
            operator2 = "="
            if questionType == "×" {
                correctAnswer = calc1 * calc2
                operand1 = String(calc1)
                operand2 = String(calc2)
            } else if questionType == "÷" {
                correctAnswer = Int.random(in: 0...13)
                calc1 = calc2 * correctAnswer
                operand1 = String(calc1)
                operand2 = String(calc2)
                
            }

       /*case "Hard":
            questionType = questionTypeArray.randomElement()!
            switch questionType {
            case "?":
                questionType = questionTypeArray[0...1].randomElement()!
                operator1 = questionType
                calc1 = Int.random(in: 0...13)
                
                if questionType == "×"{
                    correctAnswer = Int.random(in: 0...13)
                    calc2 = calc1 * calc2
                    operand1 = String(calc1)
                    operand2 = "?"
                    operand3 =
                }
            case "×":
                
            case "÷":
                
            
            }
            */
            
        default:
            calc1 = Int.random(in: 0...12)
            calc2 = Int.random(in: 0...12)
            correctAnswer = calc1 * calc2
            operand1 = String(calc1)
            operand2 = String(calc2)
            operand3 = "?"
            operator1 = "×"
            operator2 = "="
        }
        
        questionLabel.text = "\(operand1) \(operator1) \(operand2) \(operator2) \(operand3)"
    }
    
    func markAnswer(answer: String) -> Bool {
        return answer == String(correctAnswer)
    }
    
    func runTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        self.isTimerRunning = true
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    @objc func updateTimer() {
        if self.seconds < 1 {
            timer.invalidate()
            showAlert()
            self.seconds = 300
            
        } else {
            self.seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(self.seconds))
        }
    }
    
    func showAlert(){
        let title = "Well done!"
        let attempted = self.questionNumber - 1
        let message = "Your score was: \(score) / \(attempted)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in self.close() /*maybe do something else later when we make a new thing*/
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    

}
