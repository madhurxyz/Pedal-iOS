//
//  PalmCameraViewController.swift
//  Pedal
//
//  Created by Madhur Malhotra on 12/8/16.
//  Copyright © 2016 Madhur Malhotra. All rights reserved.
//

import UIKit

class PalmCameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var storage: StorageController?
    @IBOutlet weak var instructionOneLabel: UILabel!
    @IBOutlet weak var instructionTwoLabel: UILabel!
    @IBOutlet weak var instructionThreeLabel: UILabel!
    @IBOutlet weak var palmImageView: UIImageView!
    
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        if palmImageView.image != #imageLiteral(resourceName: "yourImage.jpg") {
            performSegue(withIdentifier: "ankle", sender: self)
        }
        
        else{
            let okAction = UIAlertAction(title: "Ok", style: .default)
            let alert = UIAlertController(title: "No Picture Taken", message: "Please take a picture before proceeding", preferredStyle: .alert)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            palmImageView.image = image
            palmImageView.contentMode = .scaleToFill
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    func rotate(){
        if(UIDeviceOrientationIsLandscape(UIDevice.current.orientation))
        {
            instructionOneLabel.isHidden = true
            instructionTwoLabel.isHidden = true
            instructionThreeLabel.isHidden = true
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.current.orientation))
        {
            instructionOneLabel.isHidden = false
            instructionTwoLabel.isHidden = false
            instructionThreeLabel.isHidden = false
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(PalmCameraViewController.rotate), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        storage = self.navigationController as? StorageController
        palmImageView.backgroundColor = .red
        palmImageView.clipsToBounds = true
        palmImageView.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if !storage!.didCheckLeft{
            storage!.leftPalmImage = self.palmImageView.image!.toData()!
        }
        else{
            storage!.rightPalmImage = self.palmImageView.image!.toData()!
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
