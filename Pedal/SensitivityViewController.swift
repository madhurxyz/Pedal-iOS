//
//  SensitivityViewController.swift
//  Pedal
//
//  Created by Madhur Malhotra on 12/12/16.
//  Copyright © 2016 Madhur Malhotra. All rights reserved.
//

import UIKit


class SensitivityViewController: UIViewController, SmoothViewDelegate {

    var storage:StorageController?
    
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scribbleView: SmothView!
    @IBOutlet weak var highSensitivityLabel: UILabel!
    
    @IBAction func eraseButton(_ sender: UIButton) {
    scribbleView.incrementalImage = UIImage()
    scribbleView.backgroundColor = UIColor.clear
    imageView.image = #imageLiteral(resourceName: "palmFoot.jpg")
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
        
        scribbleView.color = UIColor.red
        scribbleView.backgroundColor = .clear
        scribbleView.setBrush(5.0, alpha: 0.8)
        scribbleView.delegate = self
        if !storage!.didCheckLeft{
            imageView.image = storage!.leftPalmImage.toPicture()!
        }
        else{
            imageView.image = storage!.rightPalmImage.toPicture()!
        }
        highSensitivityLabel.adjustsFontSizeToFitWidth = true
        
        scribbleView.alpha = 1.0

    }
    
    func buildLayer(){
        self.imageView.image = UIImage(view:self.overView)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "lowSense", sender: self)
    }
    func nextButton(){

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "lowSense"{
            if !storage!.didCheckLeft {
                storage!.leftHighSense = UIImage(view: self.overView).toData()!
            }
            else{
                storage!.rightHighSense = UIImage(view: self.overView).toData()!
                //unwind to starting page
                //Save to Realm
            }
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
