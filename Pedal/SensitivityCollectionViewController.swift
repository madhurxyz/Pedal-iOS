//
//  SensitivityCollectionViewController.swift
//  Pedal
//
//  Created by Nabil K on 2017-01-14.
//  Copyright © 2017 Madhur Malhotra. All rights reserved.
//

import UIKit

class SensitivityCollectionViewController: UIViewController {

    var patient: Patient!
    var data: [UIImage]!
    var leftData: [UIImage] = []
    var rightData: [UIImage] = []
    
    var dates: [String] = []
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for c in patient.checkups.reversed() {
            leftData.append(c.left!.highSense.toPicture()!)
            leftData.append(c.left!.lowSense.toPicture()!)
            rightData.append(c.right!.highSense.toPicture()!)
            rightData.append(c.right!.lowSense.toPicture()!)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dates.append(dateFormatter.string(from: c.date))
            dates.append(dateFormatter.string(from: c.date))
        }

    }

    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        self.collectionView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

}


extension SensitivityCollectionViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return leftData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SenseCollectionCell
        let row = indexPath.row
        let leftSelected = segmentedControl.selectedSegmentIndex == 0
        
        cell.dateLabel.text! = dates[row]


        
        if leftSelected {
            cell.imageView.image = leftData[indexPath.row]
        }
        else{
            cell.imageView.image = rightData[indexPath.row]
        }
        
        if row % 2 == 0 {
            cell.senseLabel.text! = "High Sensitivity"
        }
        
        else{
            cell.senseLabel.text! = "Low Sensitivity"
        }
        
      return cell
    }
    
    
}
