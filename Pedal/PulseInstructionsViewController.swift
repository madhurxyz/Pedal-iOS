//
//  PulseInstructionsViewController.swift
//  Pedal
//
//  Created by Madhur Malhotra on 12/8/16.
//  Copyright © 2016 Madhur Malhotra. All rights reserved.
//

import UIKit

class PulseInstructionsViewController: UIViewController {

    var storage: StorageController?
    @IBOutlet weak var instructionsTitleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        instructionsTitleLabel.numberOfLines = 1
        instructionsTitleLabel.adjustsFontSizeToFitWidth = true
        
        storage = self.navigationController as! StorageController
        if storage!.didCheckRight && storage!.didCheckLeft{
            storage!.didCheckLeft = false
            storage!.didCheckLeft = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
