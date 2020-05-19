//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let softTime = 5
  let mediumTime = 7
  let hardTime = 12

  @IBAction func hardnessSelected(_ sender: UIButton) {
//    print(sender.titleLabel?.text!)
    let hardness = sender.currentTitle!
    
    switch hardness {
    case "Soft":
      print(softTime)
    case "Medium":
      print(mediumTime)
    case "Hard":
      print(hardTime)
    default:
      print("Error occure")
    }
//    if hardness == "Soft" {
//      print(5)
//    } else if  hardness == "Medium" {
//      print(7)
//    }
//    else if hardness == "Hard" {
//      print(12)
//    }
  }
}
