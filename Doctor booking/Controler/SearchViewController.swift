//
//  SearchViewController.swift
//  Doctor booking
//
//  Created by fares elsokary on 10/7/18.
//  Copyright © 2018 FaresElsokary. All rights reserved.
//

import UIKit
import Firebase
class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func signOutButtonPressed(_ sender: Any) {
        do{
       try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        }catch{
            print("error signOut \(error)")
        }
    }
    

}
