//: Playground - noun: a place where people can play

import UIKit

var myAge : Int = 37

myAge += 1

let myName : String = "Daniel"

let doubletest = 1.2232

//: Playground - noun: a place where people can play
func calculateBMI(height : Float, weight : Float){
    let bmi : Float = (weight / (height*height))
    if bmi > 25{
        print ("You are fat, with bmi \(bmi)")
    }
    else if bmi > 18.5{
        print ("You are normal with bmi \(bmi)")
    }
    else if bmi <= 18.5{
        print ("Under weight baby! with bmi \(bmi)")
    }
}


calculateBMI(height: 1.87, weight: 80.8)




