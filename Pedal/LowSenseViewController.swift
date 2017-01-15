//
//  LowSenseViewController.swift
//  Pedal
//
//  Created by Madhur Malhotra on 12/14/16.
//  Copyright © 2016 Madhur Malhotra. All rights reserved.
//


import UIKit
import RealmSwift



class LowSenseViewController: UIViewController, SmoothViewDelegate {
    
    var storage:StorageController?
    var savedData: Results<Patient>?
    
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scribbleView: SmothView!
    
    @IBOutlet weak var lowSensitivityLabel: UILabel!
    @IBOutlet weak var completeRightButton: UIButton!
    
    
    @IBAction func eraseButton(_ sender: UIButton) {
        scribbleView.incrementalImage = UIImage()
        scribbleView.backgroundColor = UIColor.clear
        
        if !storage!.didCheckLeft{
            imageView.image = storage!.leftPalmImage.toPicture()!
        }
        else{
            imageView.image = storage!.rightPalmImage.toPicture()!
        }
        
        scribbleView.setNeedsDisplay()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.storage = self.navigationController as? StorageController
        scribbleView.backgroundColor = .clear
        scribbleView.color = UIColor.blue
        scribbleView.setBrush(5.0, alpha: 0.8)
        scribbleView.delegate = self
        if !storage!.didCheckLeft{
            imageView.image = storage!.leftPalmImage.toPicture()!
            completeRightButton.setTitle("Next", for: .normal)
        }
        else{
            imageView.image = storage!.rightPalmImage.toPicture()!
            completeRightButton.setTitle("Complete", for: .normal)
        }
        
        
        scribbleView.alpha = 1.0
        lowSensitivityLabel.adjustsFontSizeToFitWidth = true

        
        // Do any additional setup after loading the view.
    }
    func buildLayer(){
        self.imageView.image = UIImage(view:self.overView)
    }
    
    @IBAction func completeRightButtonPressed(_ sender: UIButton) {
        nextButton()
    }

    func nextButton(){
        print("touching here")
        if !storage!.didCheckLeft {
            storage!.didCheckLeft = true
            storage!.leftLowSense = UIImage(view: self.overView).toData()!
            performSegue(withIdentifier: "right", sender: self)
        }
        else{
            print("checking others")
            storage!.rightLowSense = UIImage(view: self.overView).toData()!
            
            var realm = try! Realm()
            self.savedData = realm.objects(Patient)
            let thisPatient = savedData?[0]
            let newCheckup = storage!.buildCheckup()
            
            try! realm.write{
                thisPatient?.checkups.append(newCheckup)
            }
            
            if thisPatient!.checkups.count == 1 {
                performSegue(withIdentifier: "mainWelcome", sender: self)
            }
            
            else{
                performSegue(withIdentifier: "unwind", sender: self)
            }
            
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainWelcome" || segue.identifier == "unwind"{
            if  let main = segue.destination as? ViewController{
                let realm = try! Realm()
                let memory = realm.objects(Patient.self)
                main.memory = memory
            }
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

