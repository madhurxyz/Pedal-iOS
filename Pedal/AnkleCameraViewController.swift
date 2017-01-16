//
//  AnkleCameraViewController.swift
//  Pedal
//
//  Created by Madhur Malhotra on 12/9/16.
//  Copyright © 2016 Madhur Malhotra. All rights reserved.
//

import UIKit

class AnkleCameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var storage: StorageController?
    @IBOutlet weak var instructionOneLabel: UILabel!
    @IBOutlet weak var instructionTwoLabel: UILabel!
    @IBOutlet weak var instructionThreeLabel: UILabel!
    @IBOutlet weak var ankleImageView: UIImageView!

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
        
        if ankleImageView.image != #imageLiteral(resourceName: "yourImage"){
            performSegue(withIdentifier: "standing", sender: self)
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
            ankleImageView.image = image
            ankleImageView.contentMode = .scaleToFill
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
        NotificationCenter.default.addObserver(self, selector: #selector(AnkleCameraViewController.rotate), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        storage = self.navigationController as? StorageController
        addGesture()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if !storage!.didCheckLeft{
            storage!.leftAnkleImage = self.ankleImageView.image!.toData()!
        }
        else{
            storage!.rightAnkleImage = self.ankleImageView.image!.toData()!
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}


extension AnkleCameraViewController{
    
    //Refactor these for picture controllers when you get time
    func rotateImage(){
        UIView.animate(withDuration: 2.0, animations: {
            self.ankleImageView.transform = CGAffineTransform(rotationAngle: (CGFloat(M_PI)))
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
        let gesture = UIGestureRecognizer(target: self, action: #selector(openCamera))
        self.ankleImageView.addGestureRecognizer(gesture)
    }
}
