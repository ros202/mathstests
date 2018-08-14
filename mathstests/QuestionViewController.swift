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
    
    var seconds = 300
    var timer = Timer()
    var isTimerRunning = false
    var questionNumber: Int = 1
    
    @IBOutlet weak var timerLabel: UILabel!
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(QuestionViewController.updateTimer), userInfo: nil, repeats: true)
        
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
    
    func showAlert(){}
    
    func generateNewQuestion(){}
}
