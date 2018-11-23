//
//  ViewController.swift
//  Dicee
//
//  Created by testeroo on 2018-08-01.
//  Copyright © 2018 Daniel Sadavoy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var randomDiceInteger1 : Int = 0
    var randomDiceInteger2 : Int = 0
    
    
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateDiceImages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func rollButtonPressed(_ sender: UIButton) {
        
        updateDiceImages()
    }
    func updateDiceImages(){
        randomDiceInteger1 = Int(arc4random_uniform(6))
        randomDiceInteger2 = Int(arc4random_uniform(6))
        diceImageView1.image = UIImage(named: "dice\(randomDiceInteger1+1)")
        diceImageView2.image = UIImage(named: "dice\(randomDiceInteger2+1)")
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        updateDiceImages()
    }
    
}

