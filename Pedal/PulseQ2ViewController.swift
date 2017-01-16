//
//  PulseQ2ViewController.swift
//  Pedal
//
//  Created by Madhur Malhotra on 12/8/16.
//  Copyright © 2016 Madhur Malhotra. All rights reserved.
//

import UIKit

class PulseQ2ViewController: UIViewController {
    
    var storage: StorageController?
    var sliderValue: Int = 0
    var currentTime: Int = 10
    var timer: Timer?
    @IBOutlet weak var pulseSlider: UISlider!
    @IBOutlet weak var pulseDisplayLabel: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    
    @IBAction func timerButtonPressed(_ sender: Any) {
        if self.timer == nil{
            pressTimer()
        }
    }
    @IBAction func pulseSliderPressed(_ sender: UISlider) {
        sliderValue = Int(sender.value)
        pulseDisplayLabel.text = String(sliderValue)
        
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "strength", sender: self)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.text = "10"
        pulseSlider.minimumValue = 4
        pulseSlider.maximumValue = 30
        storage = self.navigationController as? StorageController
        timerButton.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if !storage!.didCheckLeft{
            storage!.leftBeats = self.sliderValue
        }
        else{
            storage!.rightBeats = self.sliderValue
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// Code for timer
extension PulseQ2ViewController{
    
    func pressTimer(){
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        self.timerLabel.text! = "Reset"
    }
    
    func updateTime(){
        if currentTime > 0 {
            currentTime -= 1
            timerLabel.text! = String(currentTime)
        }
        
        if currentTime == 0{
            currentTime = 10
            timerLabel.text! = String(currentTime)
        }
    }
}
