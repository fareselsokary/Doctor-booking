//
//  ViewController.swift
//  Doctor booking
//
//  Created by fares elsokary on 10/7/18.
//  Copyright © 2018 FaresElsokary. All rights reserved.
//

import UIKit
import Firebase
class WelcomViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil{
            performSegue(withIdentifier: "homeToSearch", sender: self)
        }
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

