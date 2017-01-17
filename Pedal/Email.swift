//
//  Email.swift
//  
//
//  Created by Nabil K on 2016-12-08.
//
//

import Foundation
import UIKit

struct Email {
    
    var recipient:String?
    var subject:String
    var images: [(data:Data,fileName:String)] = []
    var body:String
    let imageNames: [String] = ["leftHighSense", "rightHighSense", "leftLowSense", "leftHighSense","leftAnkle", "rightAnkle", "leftPalm", "rightPalm", "leftStanding", "rightStanding"]
   
    
    
    init(checkup:Checkup, recipient:String, name:String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        
        self.recipient = recipient
        self.subject = "Pedal Check from \(name) on \(dateFormatter.string(from: checkup.date))"
        

        
        //Code below is useless after refactoring...but more work to replace at this point
        let leftAnkleImageData = checkup.left!.ankle
        let leftPalmImageData = checkup.left!.palm
        let leftStandingData = checkup.left!.standing
        let leftSenseHighImageData = checkup.left!.highSense
        let leftSenseLowImageData = checkup.left!.lowSense
        
        let rightAnkleImageData = checkup.right!.ankle
        let rightPalmImageData = checkup.right!.palm
        let rightStandingData = checkup.right!.standing
        let rightSenseHighImageData = checkup.right!.highSense
        let rightSenseLowImageData = checkup.right!.lowSense
        
        let allImages: [Data?] = [leftSenseHighImageData, rightSenseHighImageData, leftSenseLowImageData, rightSenseLowImageData, leftAnkleImageData, rightAnkleImageData, leftPalmImageData, rightPalmImageData, leftStandingData, rightStandingData ]
        
        for i in 0...allImages.count - 1 {
            images.append((allImages[i]!,imageNames[i]))
        }
        
        
        let pulseFeltLeft = checkup.left!.pulse!.felt
        let pulseFeltRight  = checkup.right!.pulse!.felt
        
        var pulseLeftMessage = ""
        var pulseRightMessage = ""
        
        if pulseFeltLeft == true {
            pulseLeftMessage = "Detected"
        } else if pulseFeltLeft == false {
            pulseLeftMessage = "Not Detected"
        }
        
        if pulseFeltRight == true {
            pulseRightMessage = "Detected"
        } else if pulseFeltRight == false {
            pulseRightMessage = "Not Detected"
        }
        
        let pulseBeatLeft = checkup.left!.pulse!.beats
        let pulseBeatRight = checkup.right!.pulse!.beats
        
        let pulseStrengthLeft = checkup.left!.pulse!.strength
        let pulseStrengthRight = checkup.right!.pulse!.strength
        
        let reportLeft:String = "Left Foot: \n Pulse: \(pulseLeftMessage) \n BPM: \(pulseBeatLeft) \n Strength: \(pulseStrengthLeft) \n \n"
        let reportRight:String =  "Right Foot: \n Pulse: \(pulseRightMessage) \n BPM: \(pulseBeatRight) \n Strength: \(pulseStrengthRight)"
        
        self.body = reportLeft + reportRight
    }
    
    
}
