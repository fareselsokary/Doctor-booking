//
//  NewDovtor.swift
//  Doctor booking
//
//  Created by fares elsokary on 10/8/18.
//  Copyright © 2018 FaresElsokary. All rights reserved.
//

import UIKit
import Firebase



class NewDoctor: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIGestureRecognizerDelegate {
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var specialityTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    var imageUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGestureRecgnizer(view: profileImage)
        
    }
    
    
    
    
    func addGestureRecgnizer(view : UIView){
        let tap = UITapGestureRecognizer()
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        tap.addTarget(self, action: #selector(AddImagePicker))
        
    }
    
    
    
    
    @objc func AddImagePicker(){
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage]{
            profileImage.image = selectedImage as? UIImage
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func tapBottonPressed(_ sender: UIButton) {
        AddImagePicker()
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if let image = profileImage.image{
            uplodeProfileImage(image){url in
                self.imageUrl = url!
                self.putDtatToFireBase()
                print("0000000000000\(self.imageUrl)")
            }
        }
       
    }
    
    func putDtatToFireBase(){
        let cerrentUserId = Auth.auth().currentUser?.uid
        let messageDatabase = Database.database().reference().child("DoctorInfo/profile")
        let DictinaryInfo = ["sender" : Auth.auth().currentUser?.email, "name" : nameTextField.text!, "speciality" : specialityTextField.text!, "phoneNum" : phoneNumberTextField.text!, "address" : addressTextField.text!, "profilePhoto" : imageUrl]
        messageDatabase.child(cerrentUserId!).setValue(DictinaryInfo){
            (error , reference)in
            if error == nil{
                print("success 00000000000")
            }else{
                print("error save data to firebase\(String(describing: error))")
            }
        }
    }
    
    
    
    
    func uplodeProfileImage(_ image : UIImage, completion :@escaping((_ Url : String?)->())){
        guard let uid = Auth.auth().currentUser?.uid else{return}
        let storageRef = Storage.storage().reference().child("profilePhoto/\(uid)")
        
        let compressedImage = image.jpegData(compressionQuality: 0.7)
        let metaDate = StorageMetadata()
        metaDate.contentType = "image/jpg"
        storageRef.putData(compressedImage!, metadata: metaDate) { (metaData, error) in
            if error == nil && metaData != nil{
                
                storageRef.downloadURL(completion: { (url, error) in
                    if error == nil && url != nil{
                    completion(url!.absoluteString)
                    print(url!.absoluteString)
                    }else{
                        completion(nil)
                        print("error download url0000000000")
                    }
                })
            }else{
                completion(nil)
                print("error on upload image\(String(describing: error))")
            }
        }
    }
    
    
}
