//
//  LogIn.swift
//  Doctor booking
//
//  Created by fares elsokary on 10/7/18.
//  Copyright © 2018 FaresElsokary. All rights reserved.
//

import UIKit
import Firebase
class LogIn: UIViewController ,UITextFieldDelegate{
    
    
    @IBOutlet weak var loadWheel: UIActivityIndicatorView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
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
            continueButton.alpha = 0.4
            continueButton.setTitle("", for: .normal)
            loadWheel.isHidden = false
            loadWheel.startAnimating()
        }
    }
    
    
    
    
    func alert(message : String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("success")
            self.setContiueButton(enable: true)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    func checkTextField(){
        
        if email.text?.isEmpty == false && password.text?.isEmpty == false{
                handelSignUP()
            }else{
                alert(message: "please check all text fields")
            }
        }
    
    
    
    
    func handelSignUP(){
        
        setContiueButton(enable: false)
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (result, error) in
            if error == nil{
                self.dismiss(animated: false, completion: nil)
            }else{
                print("error signin \(String(describing: error))")
                self.setContiueButton(enable: true)
                self.alert(message: "check username and password")
                
            }
        }
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        checkTextField()
       
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
