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
        rotateImage()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        storage = self.navigationController as? StorageController
        palmImageView.backgroundColor = .red
        palmImageView.clipsToBounds = true
        palmImageView.layer.masksToBounds = true
        addGesture()
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
        self.palmImageView.isUserInteractionEnabled = true
        self.palmImageView.addGestureRecognizer(gesture)
    }

}

extension PalmCameraViewController{
    
    //Refactor these for picture controllers when you get time
    func rotateImage(){
        UIView.animate(withDuration: 2.0, animations: {
            self.palmImageView.transform = self.palmImageView.transform.rotated(by: CGFloat(M_PI_2))
        })
    }
    


}
