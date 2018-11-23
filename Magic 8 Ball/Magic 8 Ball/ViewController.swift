//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by testeroo on 2018-08-02.
//  Copyright © 2018 Daniel Sadavoy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBAction func askButtonPressed(_ sender: Any) {
        newBallImage()
    }
    var randomBallNumber: Int = 0
    func newBallImage(){
        randomBallNumber = Int(arc4random_uniform(5))
        imageView.image = UIImage(named: "ball\(randomBallNumber+1)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newBallImage()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        newBallImage()
    }


}

