//
//  StandingCameraViewController.swift
//  Pedal
//
//  Created by Madhur Malhotra on 12/9/16.
//  Copyright © 2016 Madhur Malhotra. All rights reserved.
//

import UIKit

class StandingCameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var storage: StorageController?
    @IBOutlet weak var instructionOneLabel: UILabel!
    @IBOutlet weak var instructionTwoLabel: UILabel!
    @IBOutlet weak var instructionThreeLabel: UILabel!
    @IBOutlet weak var standingImageView: UIImageView!
    @IBAction func cameraButtonPressed(_ sender: UIButton) {if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
        }
    }
    @IBAction func standingButtonPressed(_ sender: Any) {
        if standingImageView.image != #imageLiteral(resourceName: "yourImage"){
            performSegue(withIdentifier: "sensitivity", sender: self)
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
            standingImageView.image = image
            standingImageView.contentMode = .scaleToFill
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
        NotificationCenter.default.addObserver(self, selector: #selector(StandingCameraViewController.rotate), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
            storage = self.navigationController as? StorageController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if !storage!.didCheckLeft{
            storage!.leftStandingImage = self.standingImageView.image!.toData()!
        }
        else{
            storage!.rightStandingImage = self.standingImageView.image!.toData()!
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension StandingCameraViewController{
    
    //Refactor these for picture controllers when you get time
    func rotateImage(){
        UIView.animate(withDuration: 2.0, animations: {
            self.standingImageView.transform = CGAffineTransform(rotationAngle: (CGFloat(M_PI)))
        })
    }
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func addGesture(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openCamera))
        self.standingImageView.isUserInteractionEnabled = true
        self.standingImageView.addGestureRecognizer(gesture)
    }
}
