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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yaxisLabel: UILabel!

    
    var patient: Patient?
//    var left: Foot?
//    var right: Foot?
    let dateFormatter = DateFormatter()
   
    var leftLineData:[CGFloat] = []
    var rightLineData:[CGFloat] = []
    var dates:[String] = []

    @IBOutlet weak var segmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.colors[0] = UIColor(colorLiteralRed: 236.0/255.0, green: 27.0/255.0, blue: 82.0/255.0, alpha: 1.0)
        lineChart.colors[1] = UIColor(colorLiteralRed: 61.0/255.0, green: 191.0/255.0, blue: 184.0/255.0, alpha: 1.0)
        lineChart.y.axis.visible = false
        lineChart.y.axis.inset = 30
        




        dateFormatter.dateStyle = .medium
        self.dateLabel.text! = "January 16, 2017"
        
        buildLineChart()
        lineChart.animation.enabled = true
    }
    

    func buildLineChart(){
        if segmentedControl.selectedSegmentIndex == 0{
            self.leftLineData = patient!.checkups.map{CGFloat($0.left!.pulse!.beats)}
            self.rightLineData = patient!.checkups.map{CGFloat($0.right!.pulse!.beats)}
        }
        
        else{
            
            self.leftLineData = patient!.checkups.map{CGFloat($0.left!.pulse!.strength)}
            self.rightLineData = patient!.checkups.map{CGFloat($0.right!.pulse!.strength)}
        }

        
        
        self.dates = patient!.checkups.map{dateFormatter.string(from: $0.date)}
        
        
        self.leftLineData.insert(0, at: 0)
        self.rightLineData.insert(0, at: 0)

        
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
    
    @IBAction func segmentChanged(_ sender: Any) {
        
        lineChart.clearAll()
        buildLineChart()
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            titleLabel.text = "Pulse"
            yaxisLabel.text = "BPM"
        case 1:
            titleLabel.text = "Strength"
            yaxisLabel.text = "Units"
        default:
            break
        }
        
    }
    
    
    
}
