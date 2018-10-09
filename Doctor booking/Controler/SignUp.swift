//
//  SignUp.swift
//  Doctor booking
//
//  Created by fares elsokary on 10/7/18.
//  Copyright © 2018 FaresElsokary. All rights reserved.
//

import UIKit
import Firebase
class SignUp: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var userStatus: UISegmentedControl!
    
    @IBOutlet weak var loadWheel: UIActivityIndicatorView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var continueButton: RoundButtonCorners!
    @IBOutlet weak var buttonHeightConstrain: NSLayoutConstraint!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.continueButton.setTitle("Continue", for: .normal)
        loadWheel.isHidden = true
        self.loadWheel.stopAnimating()
    }
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.buttonHeightConstrain.constant = 290
            self.view.layoutIfNeeded()
        }
    }
    
    
   
    
    func setContiueButton(enable :Bool){
        if enable{
            continueButton.isEnabled = true
            continueButton.alpha = 0.7
            loadWheel.isHidden = true
            loadWheel.stopAnimating()
            continueButton.setTitle("Continue", for: .normal)
        }else{
            continueButton.isEnabled = false
            continueButton.alpha = 0.3
            continueButton.setTitle("", for: .normal)
            loadWheel.isHidden = false
            loadWheel.startAnimating()
        }
    }
    
    
    
    func alert(message : String){
        let alert = UIAlertController(title: "Hint", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .default) { (action) in
            print("success")
            self.setContiueButton(enable: true)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    //check text fields if it empty
    func checkTextField(){
        if userName.text?.isEmpty ?? true && email.text?.isEmpty ?? true && password.text?.isEmpty ?? true{
            alert(message: "please check all text fields")
        }else{
            handelSignUP()
        }
    }
    
    
    
    
    func adduserName(){
        if let userNameText = userName.text{
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = userNameText
        changeRequest?.commitChanges(completion: { (error) in
            if error == nil{
                print("user display changed")
            }
        })
        }
    }
    
    
    
    func segmentCheck(){
        if self.userStatus.selectedSegmentIndex == 0{
            self.dismiss(animated: false, completion: nil)
        }else{
            if self.userStatus.selectedSegmentIndex == 1{
                self.performSegue(withIdentifier: "signUpToAddDoctor", sender: self)
            }
        }
    }
    
    
    func handelSignUP(){
        
        setContiueButton(enable: false)
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
            if user != nil && error == nil{
                self.adduserName()
                self.segmentCheck()
            }else{
                print("error creating user\(String(describing: error?.localizedDescription))")
                self.setContiueButton(enable: true)
                self.alert(message: "please check email and password")
            }
        }
    }
    
    
    
    @IBAction func contiueButtonPressed(_ sender: RoundButtonCorners) {
        checkTextField()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
