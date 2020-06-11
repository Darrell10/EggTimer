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
    
    // MARK: - Outlet
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // MARK: - Property
    
    var player: AVAudioPlayer!
    let eggTimes = ["Soft" : 300, "Medium" : 420, "Hard" : 720]
    var timer = Timer()
    var secondsPassed = 0
    var totalTime = 0
    
    // MARK: - Function
    
    /// Function to play sound at end of timer
    private func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    /// Function to reset all timer parameters when user push on other button
    private func resetTimer() {
        timer.invalidate()
        progressBar.progress = 0.0
        secondsPassed = 0
    }
    
    // MARK: - Button Action
    
    @IBAction func hardnessSelector(_ sender: UIButton) {
        resetTimer()
        guard let hardness = sender.currentTitle else {return}
        timerLabel.text = hardness
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            guard self.secondsPassed < self.totalTime  else {
                Timer.invalidate()
                self.timerLabel.text = "Done !"
                self.playSound(soundName: "alarm_sound")
                return
            }
            self.secondsPassed += 1
            let pourcentageProgress = Float(self.secondsPassed) / Float(self.totalTime)
            self.progressBar.progress = pourcentageProgress
        }
    }
    
}
