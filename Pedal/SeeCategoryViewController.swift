//
//  seeCategoryViewController.swift
//  Pedal
//
//  Created by Nabil K on 2016-12-07.
//  Copyright © 2016 Madhur Malhotra. All rights reserved.
//

import UIKit

class SeeCategoryViewController: UIViewController {
    var selectedCategory: Category?
    var patient:Patient?
    var leftData: [(image: UIImage,image2: UIImage?, date: Date)] = []
    var rightData: [(image: UIImage,image2: UIImage?, date: Date)] = []
    let dateFormatter = DateFormatter()

    var lastIndex = 0

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateStyle = .long
        self.getDataByCategory()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
        self.collectionView.reloadData()
    }
    
    

    func getDataByCategory(){
        for checkup in patient!.checkups{
            //left side
            let imagesLeft = checkup.left!.itemByCategory(category: selectedCategory!)
            let dataLeft = (imagesLeft.0, imagesLeft.1, checkup.date)
            leftData.append(dataLeft)
        
            //right side 
            let imagesRight = checkup.right!.itemByCategory(category: selectedCategory!)
            let dataRight = (imagesRight.0, imagesRight.1, checkup.date)
            rightData.append(dataRight)
        }
    }
    
}

extension SeeCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedCategory! == .sensitivity{
            return leftData.count * 2
        }
        
        else{
            return leftData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as! CategoryCollectionViewCell
        var row = indexPath.row
        
        let leftSelected = segmentedControl.selectedSegmentIndex == 0
        let date = leftData[row].date
        cell.dateHeader.text = dateFormatter.string(from: date)
        
        switch selectedCategory!{
        
        case .ankle, .palm, .standing:
            if leftSelected{
                cell.imageForCell.image = leftData[row].image
            }
            else{
                cell.imageForCell.image = rightData[row].image
            }
        
        case .sensitivity:

            if row % 2 == 0 {
                self.lastIndex = row
                if leftSelected{
                    cell.imageForCell.image = leftData[row].image
            }
                else{
                    cell.imageForCell.image = rightData[row].image
                }
        }
            
            else {
                if leftSelected{
                    cell.imageForCell.image = leftData[row].image2
                }
                else{
                    cell.imageForCell.image = rightData[row].image2
                }
            }
        
        default:
            break
        
        }
      
        return cell
    }
    
    
    
}
