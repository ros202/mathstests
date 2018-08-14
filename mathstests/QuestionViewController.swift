//
//  QuestionViewController.swift
//  mathstests
//
//  Created by Ross Harrison on 07/08/18.
//  Copyright © 2018 Ross Harrison. All rights reserved.
//

import UIKit
import Foundation

class QuestionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var score: Int = 0
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startButtonTapped() {
        if !isTimerRunning {
            score = 0
            questionNumber = 1
            runTimer()
            generateNewQuestion()
        }
    }
    
    var seconds = 5
    var timer = Timer()
    var isTimerRunning = false
    var questionNumber: Int = 1
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    
    func generateNewQuestion(){
        let operand1 = Int.random(in: 0...12)
        let operand2 = Int.random(in: 0...12)
        let operand3 = operand1 * operand2
        let operator1 = "×"
        let operator2 = "="
        
        questionLabel.text = "\(operand1) \(operator1) \(operand2) \(operator2)"
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        
        //update selector to current ViewController...self
        
        isTimerRunning = true
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            showAlert()
            seconds = 300
            
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    func showAlert(){
        let title = "Well done!"
        let attempted = questionNumber - 1
        let message = "Your score was: \(score) / \(attempted)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in self.close() /*maybe do something else later when we make a new thing*/
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
