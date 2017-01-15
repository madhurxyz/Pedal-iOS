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
    @IBOutlet weak var pulseSlider: UISlider!
    @IBOutlet weak var pulseDisplayLabel: UILabel!
    
    @IBAction func pulseSliderPressed(_ sender: UISlider) {
        sliderValue = Int(sender.value)
        pulseDisplayLabel.text = String(sliderValue)
        
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "strength", sender: self)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pulseSlider.minimumValue = 4
        pulseSlider.maximumValue = 30
        storage = self.navigationController as? StorageController
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
