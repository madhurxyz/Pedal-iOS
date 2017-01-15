//
//  SeeCollectionViewController.swift
//  Pedal
//
//  Created by Nabil K on 2016-12-06.
//  Copyright © 2016 Madhur Malhotra. All rights reserved.
//

import UIKit

class SeeCheckupCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var pulseView: PulseView!
    
    var checkup:Checkup?
    var leftFoot: Foot?
    var RightFoot: Foot?

     // true:right, false:left
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.leftFoot = checkup!.left
        self.RightFoot = checkup!.right
    }
    
    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
        self.collectionView.reloadData()
    }
    
    
}



extension SeeCheckupCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6 // number of attributes in Right and Left foot
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        let selectedFoot: Foot?
    
        
        if self.segmentedControl.selectedSegmentIndex == 0 {
            selectedFoot = leftFoot
        }
        
        else{
            selectedFoot = RightFoot
        }
        
//        collectionView.register(CheckupCollectionViewCell.self, forCellWithReuseIdentifier: "seecheckup")

        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seecheckup", for: indexPath) as! CheckupCollectionViewCell
        
        
        switch row{

        case 0:  // high sense
            cell.image.image = selectedFoot!.highSense.toPicture()
            cell.title.text = "High Sensitivity"
        
        case 1: // low sense
            cell.image.image = selectedFoot!.lowSense.toPicture()
            cell.title.text = "Low Sensitivity"
            
        case 2: //Palm
            cell.image.image = selectedFoot!.palm.toPicture()
            cell.title.text = "Palm"
            
        case 3: //Ankle
            cell.image.image = selectedFoot!.ankle.toPicture()
            cell.title.text = "Ankle"
            
        case 4: //Standing
            cell.image.image = selectedFoot!.standing.toPicture()
            cell.title.text = "Standing"
            
        case 5:
            
            pulseView.beatsLabel.text = String(selectedFoot!.pulse!.beats)
            pulseView.stengthLabel.text = String(selectedFoot!.pulse!.strength)
//            pulseView.beatsBar.setValue(Float(selectedFoot!.pulse!.beats), animated: false)
//            pulseView.beatsBar.isEnabled = false
//        
//            pulseView.strengthBar.setValue(Float(selectedFoot!.pulse!.strength), animated: false)
            
//            pulseView.strengthBar.isEnabled = false
            pulseView.frame.size = cell.frame.size
//            pulseView.feltPulseLabel.text = "Pulse?"
            
            if selectedFoot!.pulse!.felt{
                pulseView.feltPulseImage.image = #imageLiteral(resourceName: "checkmark-for-verification")
            }
            else{
                pulseView.feltPulseImage.image = #imageLiteral(resourceName: "forbidden-mark")
            }
            
            cell.addSubview(self.pulseView)

            //cell.contentView.addSubview(cell.pulseView)

        default:
            break
        }
    
     return cell
    }
}

    
