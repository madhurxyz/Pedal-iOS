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
        rotateImage()
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

    override func viewDidLoad() {
        super.viewDidLoad()
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
        self.ankleImageView.image = Helper.imageRotatedByDegrees(oldImage: ankleImageView.image!, deg: 90)

//        UIView.animate(withDuration: 2.0, animations: {
//            self.ankleImageView.transform = self.ankleImageView.transform.rotated(by: CGFloat(M_PI_2))
//        })
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
        self.ankleImageView.isUserInteractionEnabled = true
        self.ankleImageView.addGestureRecognizer(gesture)
    }
}
