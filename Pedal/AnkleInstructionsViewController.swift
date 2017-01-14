//
//  AnkleInstructionsViewController.swift
//  Pedal
//
//  Created by Madhur Malhotra on 12/9/16.
//  Copyright © 2016 Madhur Malhotra. All rights reserved.
//

import UIKit

class AnkleInstructionsViewController: UIViewController {

    @IBOutlet weak var instructionsTitleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        instructionsTitleLabel.numberOfLines = 2
        instructionsTitleLabel.adjustsFontSizeToFitWidth = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
