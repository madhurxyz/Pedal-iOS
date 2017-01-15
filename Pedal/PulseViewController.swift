//
//  PulseViewController.swift
//  Pedal
//
//  Created by Nabil K on 2016-12-07.
//  Copyright © 2016 Madhur Malhotra. All rights reserved.
//

import UIKit
import QuartzCore

class PulseViewController: UIViewController, LineChartDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var lineChart: LineChart!
    
    var patient: Patient?
//    var left: Foot?
//    var right: Foot?
    let dateFormatter = DateFormatter()
   
    var leftLineData:[CGFloat] = []
    var rightLineData:[CGFloat] = []
    var dates:[String] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateStyle = .medium
        self.dateLabel.text! = ""
        
        buildLineChart()
        lineChart.animation.enabled = true
    }
    

    func buildLineChart(){
       
         self.leftLineData = patient!.checkups.map{CGFloat($0.left!.pulse!.beats)}
         self.rightLineData = patient!.checkups.map{CGFloat($0.right!.pulse!.beats)}
         self.dates = patient!.checkups.map{dateFormatter.string(from: $0.date)}
        
        lineChart.addLine(leftLineData)
        lineChart.addLine(rightLineData)
    }
    
    func didSelectDataPoint(_ x: CGFloat, yValues: [CGFloat]) {
        let dateIndex = Int(x)
        dateLabel.text = dates[dateIndex]
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        lineChart.setNeedsDisplay()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
