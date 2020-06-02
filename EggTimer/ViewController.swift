//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var counterLabel: UILabel!
  @IBOutlet weak var progressBar: UIProgressView!
  
  var eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
  var timer = Timer()
  
  var result = 0
  var totalTime = 0 // need to declare here to use it in func
  var secondPassed = 0
  
  var audioPlayer: AVAudioPlayer!
  
  @IBAction func hardnessSelected(_ sender: UIButton) {
    //    invalidate timer if pressed another button -> otherwise trigger Timer again
    timer.invalidate()
    
    let hardness = sender.currentTitle! // .currentTitle is optinal String?
    // titleLabel.text!
    // needs unwrapped -> let result: Int? e.x.: key can have typo "soft" instead "Soft"
    
    totalTime = eggTimes[hardness]! * 60
    
    result = totalTime // update time mm:ss
    // when clicked another button -> update % progressBar
    progressBar.progress = 0.0
    secondPassed = 0
    titleLabel.text = hardness // show which egg was clicked
    
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
  }
  
  @objc func fireTimer() {
    if secondPassed < totalTime && result > 0 {
      counterLabel.text = timeFormat(totalSecs: result) //  counterLabel.text = String("\(result) sec")
      result -= 1
      secondPassed += 1
      
      //  put line with progressBar below until secondPassed is equal to totalTime -> to show whole line 1.0 -> 100%
      progressBar.progress = Float(secondPassed) / Float(totalTime) // Int/Int -> Float(Int/Int) => 5/2= 2.0!! no remaining
      
    } else {
      timer.invalidate()
      counterLabel.text = String("Finished!")
      
      playSound(soundName: "alarm_sound")
      
      //      Refresh to default screen
      DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
        self.titleLabel.text = "How do you like your eggs?"
        self.counterLabel.text = ""
        self.progressBar.progress = 0.5
      }
    }
  }
  
  func playSound(soundName: String) {
    let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
    audioPlayer = try! AVAudioPlayer(contentsOf: url!)
    audioPlayer.play()
  }
  
  //  Format the time in min & secs
  func timeFormat(totalSecs: Int) -> String {
    let secs: Int = totalSecs % 60
    let mins: Int = (totalSecs / 60 ) % 60
    return String(format: "%02d:%02d", mins, secs)
  }
  
}

/*
 //using closures:
 let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
 print("Timer fired!")
 }
 */

//    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
//      if self.result > 0 {
//        print ("\(self.result) seconds")
//        self.result -= 1
//      }
//    }
