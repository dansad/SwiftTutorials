//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        pickedAnswer = sender.tag == 1 ? true : false
        
        checkAnswer()
  
    }
    
    
    func updateUI() {
        progressBar.frame.size.width = (view.frame.size.width / 13 ) * (questionNumber + 1)
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1)/\(allQuestions.list.count)"
        questionLabel.text = allQuestions.list[questionNumber].questionText
        pickedAnswer = allQuestions.list[questionNumber].answer
      
    }
    

    func nextQuestion() {
        if questionNumber <= allQuestions.list.count - 1{
            updateUI()
        }
        else{
            let alert = UIAlertController(title: "End of Quiz", message: "You finished all the quesions. Want to start over?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {(UIAlertAction) in self.startOver()})
            
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
            
        }
       
        
    }
    
    
    func checkAnswer() {
        
        if pickedAnswer == allQuestions.list[questionNumber].answer{
            score += 1
            print("You got it!")
        }
        else{
            print("Wrong!")
        }
            questionNumber += 1
        nextQuestion()
    }
    
    
    func startOver() {
        questionNumber = 0
        score = 0
        nextQuestion()
        
       
    }
    

    
}
