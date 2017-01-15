//
//  LeftFootViewController.swift
//  Pedal
//
//  Created by Madhur Malhotra on 12/13/16.
//  Copyright © 2016 Madhur Malhotra. All rights reserved.
//

import UIKit

class LeftFootViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var leftFootImageView: UIImageView!
    @IBOutlet weak var leftFootLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        leftFootLabel.adjustsFontSizeToFitWidth = true
        startButton.layer.cornerRadius = 10

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
