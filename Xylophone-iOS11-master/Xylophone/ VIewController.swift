//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{
    
    var audioplayer : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }



    @IBAction func notePressed(_ sender: UIButton) {
        var selectedSoundFileName = "note\(sender.tag)"
        playSound(soundFile : selectedSoundFileName)
        
    }
    
    func playSound(soundFile : String){
        let soundURL = Bundle.main.url(forResource: soundFile, withExtension: "wav")
        do{
            audioplayer = try AVAudioPlayer(contentsOf: soundURL!)
        }
        catch{
            print(error)
        }
        audioplayer.play()
    }
    
    
    
  

}

