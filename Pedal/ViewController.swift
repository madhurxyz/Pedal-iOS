//
//  ViewController.swift
//  PedalWelcomeViewController
//
//  Created by Madhur Malhotra on 12/1/16.
//  Copyright © 2016 Madhur Malhotra. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift



class ViewController: UIViewController {

    @IBOutlet weak var youCheckedLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastCheckLabel: UILabel!
    @IBOutlet weak var recommendationLabel: UILabel!
    @IBOutlet weak var checkupButton: UIButton!
    @IBOutlet weak var recordsButton: UIButton!
    
    var alert: UIAlertController?
    var nameAlert: UIAlertController?
    var memory: Results<Patient>?
    var thisPatient:Patient?
    var name = ""
    let calendar =  Calendar(identifier: .gregorian)
    let format = DateComponentsFormatter()
    
    
    @IBAction func chekupButtonPressed(_ sender: Any) {
        if self.thisPatient == nil{
            performSegue(withIdentifier: "settings", sender: self)
        }
        
        else{
            performSegue(withIdentifier: "checkup", sender: self)
        }
    
    }
    @IBAction func recordsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "records", sender: self)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let memory = self.memory{
            if memory.count > 0{
                self.setRecommendation()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.formatButtons()
        
        //Manage Realm
        let realm = try! Realm()
        memory = realm.objects(Patient)
        
        if memory?.count == 0 {
            self.nameLabel.text = ""
            self.lastCheckLabel.text! = ""
            self.recordsButton.isHidden = true
            self.checkupButton.setTitle("Get Started", for: .normal)
            
            self.lastCheckLabel.text! = "Welcome to Pedal! Get started with your first check by pressing the button below"
            self.youCheckedLabel.isHidden = true
            self.recommendationLabel.text! = ""
        }
            

        else {
            self.setup()
        }
    }
    
    func setRecommendation(){
        let todaysDate = Date()
        var lastCheckDate: Date?
        if thisPatient!.checkups.count > 0 {
            lastCheckDate = thisPatient!.checkups[thisPatient!.checkups.count - 1].date
            let lastCheck = format.string(from: lastCheckDate!, to: todaysDate)
            youCheckedLabel.isHidden = false
            lastCheckLabel.text = decideInterval().ago
            self.recommendationLabel.text = decideInterval().next
            self.recordsButton.isHidden = false
        }
            
        else{
            self.youCheckedLabel.isHidden = true
            self.lastCheckLabel.text! = "Welcome to Pedal! Get started with your first check by pressing the button below"
            self.recommendationLabel.text! = ""
            self.recordsButton.isHidden = true
        }
        
        if let nav = self.navigationController {
//            nav.dismiss(animated: false, completion: nil)
        }
    }
    
    
    func formatButtons(){
        format.maximumUnitCount = 2
        format.unitsStyle = .full
        format.allowedUnits = [.weekOfMonth]

        //Welcome Labels
        
        lastCheckLabel.adjustsFontSizeToFitWidth = true
        
        //Checkup Button
        checkupButton.layer.cornerRadius = 10
        
        //Records Button Style
        recordsButton.backgroundColor = .clear
        recordsButton.layer.cornerRadius = 10
        recordsButton.layer.borderWidth = 1.5
        recordsButton.layer.borderColor = UIColor(red: 241.0/255.0, green: 90.0/255.0, blue: 91.0/255.0, alpha: 0.8).cgColor
    }
    
    func setup(){
        thisPatient = memory?[0]
        name = thisPatient!.name
        setRecommendation()
        nameLabel.text = "Hi \(name),"
        

    }
    
    func decideInterval() -> (ago:String, next:String){
        let todaysDate = Date()
        var lastCheckDate: Date = thisPatient!.checkups.last!.date
        let interval = todaysDate.timeIntervalSince(lastCheckDate)
        let secondsInWeek:Double = 604800
        let numWeeks = interval/secondsInWeek
        
        if numWeeks < 1{
            return ("recently.", "Your next checkup is in 3 weeks!")
        }
            
        else if numWeeks < 2{
            return("1 week ago.", "Your next checkup is in 2 weeks!")
        }
            
        else if numWeeks < 3{
            return("2 weeks ago.", "Your next checkup is in a week!")
        }
            
        else{
            return("3+ weeks ago.", "You should check your feet today!")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "records"{
            if let nav = segue.destination as? UINavigationController{
                let records = nav.viewControllers.first as! RecordsViewController
                records.patient = self.thisPatient
            }
        }
    }
    
    
    @IBAction func unwindFromCheckup(segue:UIStoryboardSegue){
        
    }
    
    @IBAction func unwindFromSettings(segue:UIStoryboardSegue){
        
    }
}


extension ViewController{
    
    func createAlerts(){
        
        self.alert = UIAlertController(title: "Welcome!", message: "Please enter the following information (only shared with your doctor) to get started with Pedal. These can be changed at any time", preferredStyle: .alert)
        
        
        
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: { action in
            if (self.alert!.textFields?[0].text?.characters.count)! > 1 {
                let name = self.alert!.textFields?[0].text
                let email = self.alert!.textFields?[1].text ?? ""
                let doctorEmail = self.alert!.textFields?[2].text ?? ""
                let patient = Patient(name: name!, email: email, doctorEmail: doctorEmail)
                
                let realm = try! Realm()
                
                try! realm.write{
                    realm.add(patient)
                }
                
                self.memory = realm.objects(Patient)
                self.setup()
            }
                
            else{
                self.present(self.nameAlert!, animated: true, completion: nil)
            }
        })
        
        
        alert!.addAction(submitAction)
        alert!.addTextField(configurationHandler: { textField in
            textField.placeholder = "name"
        })
        alert!.addTextField(configurationHandler: { textField in
            textField.placeholder = "email"
        })
        alert!.addTextField(configurationHandler: { textField in
            textField.placeholder = "Your Doctor's Email"
        })
        
        // Alert for improperly formatted name
        self.nameAlert = UIAlertController(title: "Improper name formatting", message: "Please Use a name at least two characters long", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        self.nameAlert!.addAction(okAction)
        //        self.present(self.alert!, animated: true, completion: nil)
    }

    
}

