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
    let imageNames: [String] = ["leftAnkle", "rightAnkle", "leftPalm", "rightPalm", "leftStanding", "rightStanding", "leftHighSense", "rightHighSense", "leftLowSense", "leftHighSense"]
   
    
    
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
        
        let allImages: [Data?] = [leftAnkleImageData, rightAnkleImageData, leftPalmImageData, rightPalmImageData, leftStandingData, rightStandingData, leftSenseHighImageData, rightSenseHighImageData, leftSenseLowImageData, rightSenseLowImageData]
        
        for i in 0...allImages.count - 1 {
            images.append((allImages[i]!,imageNames[i]))
        }
        
        let pulseFeltRight = checkup.left!.pulse!.felt
        let pulseFeltLeft  = checkup.right!.pulse!.felt
        
        let pulseBeatLeft = checkup.left!.pulse!.beats
        let pulseBeatRight = checkup.right!.pulse!.beats
        
        let pulseStrengthLeft = checkup.left!.pulse!.strength
        let pulseStrengthRight = checkup.right!.pulse!.strength
        
        let reportRight:String = "Left Foot: \n Pulse: \(pulseFeltLeft) \n BPM: \(pulseBeatLeft) \n Strength: \(pulseStrengthLeft) \n \n"
        let reportLeft:String =  "Right Foot: \n Pulse: \(pulseFeltRight) \n BPM: \(pulseBeatRight) \n Strength: \(pulseStrengthRight)"
        
        self.body = reportRight + reportLeft
    }
    
    
}
