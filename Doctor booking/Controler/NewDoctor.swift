//
//  NewDovtor.swift
//  Doctor booking
//
//  Created by fares elsokary on 10/8/18.
//  Copyright © 2018 FaresElsokary. All rights reserved.
//

import UIKit
import Firebase



class NewDoctor:  UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIGestureRecognizerDelegate {
    
    
    let imagePicker = UIImagePickerController()
    var newDayArray = [String]()

    let speclityArray = ["Dentistry", "Psychiatry", "Neurology", "Ear, Nose and Throat", "Cardiology and Vascular Disease", "Audiology", "Chest adn Respiratory", "Diabetes an Endocrinology", "Elders"]
    
    let pickerViewAlert = UIPickerView(frame:
        CGRect(x: 0, y: 50, width: 270, height: 162))

    
    
    
    // /////////////////////////////
    @IBOutlet weak var dayPickerView: UIPickerView!
    
    @IBOutlet weak var toHour: UIPickerView!
    @IBOutlet weak var toMinute: UIPickerView!
    @IBOutlet weak var toAmPm: UIPickerView!
    
    @IBOutlet weak var fromAmPm: UIPickerView!
    @IBOutlet weak var fromMinute: UIPickerView!
    @IBOutlet weak var fromhour: UIPickerView!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var specialityTextField: UIButton!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var feesTextField: UITextField!
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var imageUrl = ""
    let Day = ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    let hour = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    let minute = ["00", "15", "30", "45"]
    let PmAm = ["Pm", "Am"]
    var A = "1"
    var B = "00"
    var C = "Pm"
    var D = "1"
    var E = "00"
    var F = "Pm"
    
    var dayDateTime : String = "Saturday"
    var openDay = "Saturday"
    var FromTime = "1:00 Pm"
    var toTime = "1:00 Pm"
    
    
    
   // /////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        dayPickerView.delegate = self
//        dayPickerView.dataSource = self
        addGestureRecgnizer(view: profileImage)

    }
    
    // ///////////////////////////////////////////////
    
    
    
   
    
    
    
    
    func PickerViewAlert(){
        
    let alertView = UIAlertController(title: "Select item from list",message:"\n\n\n\n\n\n\n\n\n",preferredStyle: .alert)
    pickerViewAlert.delegate = self
    pickerViewAlert.dataSource = self
    alertView.view.addSubview(pickerViewAlert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){alertAction in
            
        }
        
    alertView.addAction(action)
    present(alertView, animated: true, completion: nil)
    
    }
    
    
    
    
    
    
    
    
    
    
    //Add GestureRecgnizer to profile photo
    
    func addGestureRecgnizer(view : UIView){
        let tap = UITapGestureRecognizer()
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        tap.addTarget(self, action: #selector(AddImagePicker))
        
    }
    
    
    // Get photo from imagePicker
    
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
    
    
    @IBAction func specialityButtonPressed(_ sender: UIButton) {
        
    PickerViewAlert()
        
    }
    
    @IBAction func tapBottonPressed(_ sender: UIButton) {
        AddImagePicker()
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        do{
            try Auth.auth().signOut()
        }catch{
            print("error sign out\(error)")
        }
        
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    //Get image url and save data to firebase
    @IBAction func saveButtonPressed(_ sender: Any) {
        if let image = profileImage.image{
            uplodeProfileImage(image){url in
                self.imageUrl = url!
                self.putDtatToFireBase()
                print("0000000000000\(self.imageUrl)")
            }
        }
    }
    
    
    //Save data to firebase
    
    func putDtatToFireBase(){
        let cerrentUserId = Auth.auth().currentUser?.uid
        let messageDatabase = Database.database().reference().child("DoctorInfo/profile")
        let DictinaryInfo = ["sender" : Auth.auth().currentUser?.email! as Any, "name" : nameTextField.text!, "speciality" : specialityTextField.titleLabel?.text! as Any, "phoneNum" : phoneNumberTextField.text!, "address" : addressTextField.text!, "profilePhoto" : imageUrl, "openDays" : newDayArray, "fees" : feesTextField.text!] as [String : Any]
        messageDatabase.child(cerrentUserId!).setValue(DictinaryInfo){
            (error , reference)in
            if error == nil{
                print("success 00000000000")
            }else{
                print("error save data to firebase\(String(describing: error))")
            }
        }
    }
    
    
    
    //Upload image to firebase
    
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










extension NewDoctor : UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == dayPickerView{
            return Day.count
        }else if pickerView == fromhour || pickerView == toHour{
            return hour.count
        }else if pickerView == fromAmPm || pickerView == toAmPm{
            return PmAm.count
        }else if pickerView == pickerViewAlert{
            
            return speclityArray.count
        }else {
            return minute.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == dayPickerView{
            return Day[row]
        }else if pickerView == fromhour || pickerView == toHour{
            return hour[row]
        }else if pickerView == fromAmPm || pickerView == toAmPm{
            return PmAm[row]
        }else if pickerView == pickerViewAlert{
            return speclityArray[row]
        }else {
            return minute[row]
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == dayPickerView{
            dayDateTime = Day[row]
        }else if pickerView == fromhour {
            A = hour[row]
        }else if  pickerView == fromMinute{
            B = minute[row]
        }
        else if pickerView == fromAmPm {
            C = PmAm[row]
        }else if pickerView == toHour{
            D = hour[row]
        }else if pickerView == toMinute{
            E = minute[row]
        }else if pickerView == toAmPm{
            F = PmAm[row]
        }else if pickerView == pickerViewAlert{
            if specialityTextField.titleLabel?.text == nil{
                specialityTextField.setTitle("Dentistry", for: .normal)
            }else{
                specialityTextField.setTitle(" \(speclityArray[row])", for: .normal)
            }
            
        }
        
       openDay = dayDateTime
        FromTime = A + ":" + B + "" + C
        toTime = D + ":" + E + "" + F
        print(openDay,FromTime,toTime)
    }
    

    
    // /////////////////////////
    
    
   
    
    
}

extension NewDoctor : UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = newDayArray[indexPath.row]
        cell.textLabel?.textAlignment = .center
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newDayArray.count
        
    }
    func addNewDay(){
        let DayTime = openDay + " " + FromTime + " " + toTime
        newDayArray.append(DayTime)
        tableView.reloadData()
        print(newDayArray)
    }
    
    @IBAction func addDateButtonPressed(_ sender: Any) {
        
        addNewDay()
        
    }
    
    
}


