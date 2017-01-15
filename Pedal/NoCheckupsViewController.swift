//
//  NoCheckupsViewController.swift
//  Pedal
//
//  Created by Madhur Malhotra on 1/12/17.
//  Copyright © 2017 Madhur Malhotra. All rights reserved.
//

import UIKit
import RealmSwift

class NoCheckupsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionOneLabel: UILabel!
    @IBOutlet weak var checkupButton: UIButton!
    var patient:Patient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        let memory = realm.objects(Patient.self)
        self.patient = memory[0]
        
        nameLabel.text! = "Hi \(self.patient!.name),"
        // Do any additional setup after loading the view.
        nameLabel.adjustsFontSizeToFitWidth = true
        descriptionOneLabel.adjustsFontSizeToFitWidth = true
        checkupButton.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func settingsButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "settings", sender: self)
    }
    
    @IBAction func unwindFromSettings2(segue:UIStoryboardSegue){
        
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "settings"{
            if let settings = segue.destination as? SettingsViewController{
                settings.patient = self.patient
                if let patient = self.patient{
                    settings.patient = patient
                }
            }
            
        }
        
    
    }
}
