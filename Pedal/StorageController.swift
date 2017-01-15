//
//  CustomNavigationController.swift
//  Pedal
//
//  Created by Madhur Malhotra on 12/6/16.
//  Copyright © 2016 Madhur Malhotra. All rights reserved.
//

import UIKit

class StorageController: UINavigationController, UINavigationControllerDelegate, UINavigationBarDelegate {
    var didCheckLeft = false
    var didCheckRight = false
    
    //Pulse
    var leftFelt: Bool = false
    var leftBeats: Int = 0
    var leftStrength: Int = 0
    
    var rightFelt: Bool = false
    var rightBeats: Int = 0
    var rightStrength: Int = 0
    
    //Sensitivity
    var leftHighSense: Data = Data()
    var leftLowSense: Data = Data()
    
    var rightHighSense: Data = Data()
    var rightLowSense: Data = Data()
    
    //Palm
    var leftPalmImage: Data = Data()
    var rightPalmImage: Data = Data()
    
    //Ankle
    var leftAnkleImage: Data = Data()
    var rightAnkleImage: Data = Data()
    
    //Standing
    var leftStandingImage: Data = Data()
    var rightStandingImage: Data = Data()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        navigationBar.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func buildCheckup() -> Checkup {
        
        //Date
        let date = Date()
        
        //Sent
        let sent = false
        
        //Left
        let leftPulse = Pulse(felt: leftFelt, beats: leftBeats, strength: leftStrength)
        
        
        //Right
        let rightPulse = Pulse(felt: rightFelt, beats: rightBeats, strength: rightStrength)
        
        
        //LeftFoot
        let leftFoot = Foot(side: false, pulse: leftPulse, palm: leftPalmImage, ankle: leftAnkleImage, standing: leftStandingImage, highSense: leftHighSense, lowSense: leftLowSense)
        
        //RightFoot
        let rightFoot = Foot(side: true, pulse: rightPulse, palm: rightPalmImage, ankle: rightAnkleImage, standing: rightStandingImage, highSense: rightHighSense, lowSense: rightLowSense)
        
        //Checkup
        let checkup = Checkup(left: leftFoot, right: rightFoot, date: date, sent: sent)
        
        return checkup
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    
    func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
        self.navigationBar.topItem?.title = "Checkup"
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationBar.topItem?.backBarButtonItem = backButton
        return false
    }
    
    
    
}
