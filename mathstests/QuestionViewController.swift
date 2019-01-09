//
//  QuestionViewController.swift
//  mathstests
//
//  Created by Ross Harrison on 07/08/18.
//  Copyright © 2018 Ross Harrison. All rights reserved.
//

import UIKit
import Foundation
public extension UITextField {
    
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.cut) || action == #selector(UIResponderStandardEditActions.copy)
    }
    
    public func hideAssistantBar()
    {
        if #available(iOS 9.0, *) {
            let assistant = self.inputAssistantItem;
            assistant.leadingBarButtonGroups = [];
            assistant.trailingBarButtonGroups = [];
        }
    }
}

class QuestionViewController: UIViewController, UITextFieldDelegate, KeyboardDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.difficultyLabel.text = level.title
        self.difficultyLabel.textColor = level.colour
        self.seconds = level.timeAllowed
        
        let keyboardView = KeyboardView(frame: CGRect(x: 0, y: 0, width: 0, height: 300))
        keyboardView.delegate = self  // the vc will be notified by the keyboard whenever a key is tapped
        answerField.inputView = keyboardView
        self.answerField.hideAssistantBar()
        self.answerField.isEnabled = false
        
        
    }
    
    public var level: Level = Level()
    
    private var score: Int = 0
    private var seconds: Int = 60
    private var timer = Timer()
    private var isTimerRunning = false
    private var questionNumber: Int = 1
    private var correctAnswer: Int = 0
    
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
                action in self.close()
            })
            let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            alert.addAction(yesAction)
            alert.addAction(noAction)
            present(alert, animated: true, completion: nil)
        } else {
            close()
        }
    }
    
    func keyWasTapped(character: String) {
        
        if character == "←" {
            answerField.deleteBackward()
        } else if character == "⏎" {
            answerTyped(self.answerField)
            answerField.text = ""
        } else if answerField.text!.count < 8 {
            if let input: Int = Int(character) {
                answerField.insertText(String(input))
            } else {
                answerField.insertText("")
            }
        } else {
            answerField.insertText("")
        }
        
        /// Let's add some cases for return and delete...
        
    }
    
    
    func close(){
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func startButtonTapped() {
        if !self.isTimerRunning {
            score = 0
            self.questionNumber = 1
            scoreLabel.text = "\(score)/\(questionNumber-1)"
            questionNumberLabel.text = "Question: \(questionNumber)"
            
            self.answerField.isEnabled = true
            answerField.becomeFirstResponder()
            runTimer()
            questionLabel.text = level.questions[questionNumber-1].questionText
            
        }
    }
    
    @IBAction func answerTyped(_ textField: UITextField) {
        let givenAnswer = textField.text
        if markAnswer(answer: givenAnswer ?? "") {
            self.score += 1
        }
        scoreLabel.text = "\(score)/\(questionNumber)"
        self.questionNumber += 1
        questionNumberLabel.text = "Question: \(questionNumber)"
        textField.text = ""
        questionLabel.text = level.questions[questionNumber-1].questionText
        
    }

 
    
    func markAnswer(answer: String) -> Bool {
        return answer == String(level.questions[questionNumber-1].correctAnswer)
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
            self.seconds = level.timeAllowed
            
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
