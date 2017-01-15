//
//  SettingsViewController.swift
//  Pedal
//
//  Created by Nabil K on 2017-01-08.
//  Copyright © 2017 Madhur Malhotra. All rights reserved.
//

import UIKit
import RealmSwift

class SettingsViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var doctorEmailTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    
    var nameAlert: UIAlertController?
    var patient: Patient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let patient = self.patient{
            self.nameTextField.text = patient.name ?? ""
            self.emailTextField.text = patient.email ?? ""
            self.doctorEmailTextField.text = patient.doctorEmail ?? ""
            
        }
        saveButton.layer.cornerRadius = 10
        
        
        self.nameAlert = UIAlertController(title: "Improper name formatting", message: "Please Use a name at least two characters long", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        nameAlert?.addAction(okAction)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
        
        
    }
    
    func viewTapped() {
        print("view is tapped")
        view.endEditing(true)
        
    }
    
    func validCredentials() -> Bool{
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
//        let doctorEmail = doctorEmailTextField.text ?? ""
        
        let valid = name.characters.count > 0 && email.characters.count > 0
        
        return valid
    
    }



    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let realm = try! Realm()
        let memory = realm.objects(Patient.self)
        
        if segue.identifier == "seeTempWelcome" || segue.identifier == "unwindToTempWelcome"{
            if let tempWelcomeScreen = segue.destination as? NoCheckupsViewController{
                if memory.count < 1 {
                    let patient = Patient(name: nameTextField.text!, email: emailTextField.text!, doctorEmail: doctorEmailTextField.text!)
                    try! realm.write{
                        realm.add(patient)
                    }
                    tempWelcomeScreen.patient = patient
                }
                
                else{
                    let patient = tempWelcomeScreen.patient!
                    try! realm.write {
                        patient.name = nameTextField.text!
                        patient.email = emailTextField.text!
                        patient.doctorEmail = doctorEmailTextField.text ?? ""
                    }
                    tempWelcomeScreen.nameLabel.text! = "Hi \(patient.name),"
                }
            }
        
        
        if segue.identifier == "welcome"{
            if let welcomeScreen = segue.destination as? ViewController{
                
                let patient = welcomeScreen.memory![0]
                try! realm.write{
                    patient.name = nameTextField.text!
                    patient.email = emailTextField.text!
                    patient.doctorEmail = doctorEmailTextField.text ?? ""
                }

                welcomeScreen.memory = realm.objects(Patient.self)
                welcomeScreen.setup()
            }
        }
        
    }
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        if self.validCredentials(){
            if let patient = self.patient {
                if patient.checkups.count > 0 {
                    performSegue(withIdentifier: "welcome", sender: self)
                }
                
                // Going back to tempWelcome
                else{
                    performSegue(withIdentifier: "unwindToTempWelcome", sender: self)
                }
            }
            //Going to tempWelcome for the first time
            else {
                performSegue(withIdentifier: "seeTempWelcome", sender: self)
            }
        }
        
        else{
            self.present(nameAlert!, animated: true, completion: nil)
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
