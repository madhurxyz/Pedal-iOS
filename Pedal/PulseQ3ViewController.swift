//
//  PulseQ3ViewController.swift
//  Pedal
//
//  Created by Madhur Malhotra on 12/8/16.
//  Copyright © 2016 Madhur Malhotra. All rights reserved.
//

import UIKit

class PulseQ3ViewController: UIViewController {

    var storage: StorageController?
    var sliderValue: Int = 0
    @IBOutlet weak var strengthDisplayLabel: UILabel!
    @IBOutlet weak var strengthSlider: UISlider!
    @IBAction func strengthSliderPressed(_ sender: UISlider) {
        sliderValue = Int(sender.value)
        strengthDisplayLabel.text = String(sliderValue)
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "palm", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        strengthSlider.minimumValue = 1
        strengthSlider.maximumValue = 10
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
