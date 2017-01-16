//
//  CheckUpDateViewController.swift
//  Pedal
//
//  Created by Nabil K on 2016-12-06.
//  Copyright © 2016 Madhur Malhotra. All rights reserved.
//

import UIKit
import MessageUI
import RealmSwift

class RecordsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var patient:Patient?
    var sortByDate = true
    var categories:[String] = ["Pulse", "Palm", "Ankle", "Standing", "Sensitivity",]
    var selectedCategory: Category?
    var selectedCheckup: Checkup?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var changeDataButton: UIButton!
    

   
    override func viewDidLoad() {
        super.viewDidLoad()
        changeDataButton.setTitle("Sort by Category", for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func assignImage(category:Category) -> UIImage{
        switch category{
        case .sensitivity:
            return #imageLiteral(resourceName: "pain")
        case .pulse:
            return #imageLiteral(resourceName: "heart-beat")
        case .palm:
            return #imageLiteral(resourceName: "footprint-black")
        case .ankle:
            return #imageLiteral(resourceName: "women-foot")
        case .standing:
            return #imageLiteral(resourceName: "foot-side-view-outline")
        }
    }
    
    // Switch from dates to categories and vice versa
    @IBAction func changeData(){
        if self.sortByDate{
            //changing to categories
            self.changeDataButton.setTitle("Sort by Date", for: .normal)
        }
        else{
            self.changeDataButton.setTitle("Sort by Category", for: .normal)
        }
        self.sortByDate = !self.sortByDate
        tableView.reloadData()
    }
    
    func sendCheckup(checkup:Checkup){
       
        let email:Email = Email(checkup: checkup, recipient: patient!.doctorEmail, name: patient!.name)
        let recipients: [String] = [patient!.doctorEmail, patient!.email]
        
        
        if MFMailComposeViewController.canSendMail(){
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(recipients)
            mail.setSubject(email.subject)
            mail.setMessageBody(email.body, isHTML: false)
            for i in email.images{
                mail.addAttachmentData(i.data, mimeType: "image/png", fileName: i.fileName)
            }
            
            self.present(mail, animated:true, completion:nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seeCheckup"{
            if let seeCheckupCollectionVc = segue.destination as? SeeCheckupCollectionViewController{
                seeCheckupCollectionVc.checkup = selectedCheckup
            }
        }
        
        else if segue.identifier == "seeCategory"{
            if let seeCategory = segue.destination as? SeeCategoryViewController{
                seeCategory.patient = self.patient
                seeCategory.selectedCategory = self.selectedCategory
            }
        }
        
        else if segue.identifier == "seePulse" {
            if let pulseVc = segue.destination as? PulseViewController{
                pulseVc.patient = self.patient
                
            }
        }
        
        else if segue.identifier == "seeSensitivity"{
            if let senseVc = segue.destination as? SensitivityCollectionViewController{
                senseVc.patient = self.patient
            }
        }
    }
}




extension RecordsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sortByDate{
            return patient!.checkups.count
        }
        
        else{
            return categories.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "checkup") as! RecordsTableViewCell
        
        if sortByDate{
            let checkup = patient!.checkups.reversed()[indexPath.row]
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            
            cell.title.text = dateFormatter.string(from: checkup.date)
            cell.sentButton.setBackgroundImage(#imageLiteral(resourceName: "mail-sent"), for: .normal)
            
            if !checkup.sent{
                cell.sentButton.alpha = CGFloat(0.50)
            }
        }
        
        else{
            
            let thisCategory = categories[indexPath.row]
            self.selectedCategory = Category(rawValue: thisCategory)
            cell.title.text! = thisCategory
            let imageForCategory = assignImage(category: Category(rawValue: thisCategory)!)
            cell.sentButton.setBackgroundImage(imageForCategory, for: .normal)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if sortByDate{
            selectedCheckup = self.patient!.checkups.reversed()[indexPath.row]
            performSegue(withIdentifier: "seeCheckup", sender: self)
        }
        else{
            selectedCategory = Category(rawValue: self.categories[indexPath.row])
           
            if selectedCategory == .pulse {
                if patient!.checkups.count > 1{
                    performSegue(withIdentifier: "seePulse", sender: self)
                }
                else{
                    let alert = UIAlertController(title: "Chart Needs More Data", message: "You need at least two checkups to see your progress on a chart", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
                
            else if selectedCategory == .sensitivity{
                performSegue(withIdentifier: "seeSensitivity", sender: self)
            }
                
            
            else{
                performSegue(withIdentifier: "seeCategory", sender: self)
            }

        }
    }
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var send:UITableViewRowAction?
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            let deleteAlert = UIAlertController(title: "Delete checkup?", message: "Are you sure you want to delete this checkup?", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "DELETE", style: .default, handler: { action in
                let checkups = self.patient!.checkups
                let mostRecentCheckup = checkups.last!
                let checkForRow = checkups[index.row]
                if mostRecentCheckup  != checkForRow{
                    let realm = try! Realm()
                    try! realm.write {
                        checkups.remove(objectAtIndex: index.row)
                    }
                    tableView.reloadData()
                }
                else{
                    let alert = UIAlertController(title: "Cannot Delete This Checkup", message: "You cannot delete the most recent checkup", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            deleteAlert.addAction(okAction)
            deleteAlert.addAction(cancelAction)
            self.present(deleteAlert, animated: true, completion: nil)
        }
        
        if sortByDate{
            send = UITableViewRowAction(style: .normal, title: "Send") { action, index in
                let checkup = self.patient!.checkups[index.row]
                self.sendCheckup(checkup: checkup)
            }
            delete.backgroundColor = UIColor.red
            send!.backgroundColor = UIColor.blue
            return [send!, delete]
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if sortByDate{
            return .delete
        }
        else {
            return .none
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
