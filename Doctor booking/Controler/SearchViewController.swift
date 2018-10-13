//
//  SearchViewController.swift
//  Doctor booking
//
//  Created by fares elsokary on 10/11/18.
//  Copyright © 2018 FaresElsokary. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let realm = try! Realm()
    var DoctorInfoArray : Results<DoctorInfo>?
    var selectedRow : String = ""
    @IBOutlet weak var searchByName: UIButton!
    @IBOutlet weak var searchBySpeciality: UIButton!
    @IBOutlet weak var SpeclitytableView: UITableView!
    
    
    let speclityArray = ["Dentistry", "Psychiatry", "Neurology", "Ear, Nose and Throat", "Cardiology and Vascular Disease", "Audiology", "Chest adn Respiratory", "Diabetes an Endocrinology", "Elders"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DoctorInfoArray = realm.objects(DoctorInfo.self)
        SpeclitytableView.isHidden = true
        getDoctorInfo()
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpeclityCell", for: indexPath)
        cell.textLabel?.text = speclityArray[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speclityArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)
        DoctorInfoArray = DoctorInfoArray?.filter("Speciality CONTAINS[cd] %@", currentCell?.textLabel?.text! ?? "")
        performSegue(withIdentifier: "GoToSearchReasult", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVc = segue.destination as! SearchResultViewController
        if searchByName.isTouchInside == true{
            destinationVc.searchBarIsHidden = false
        }
        destinationVc.ResultArray = DoctorInfoArray
    }
    
    
    
    // /////////////////////////////////
    
    @IBAction func SpecialithSearchPressed(_ sender: UIButton) {
        
        SpeclitytableView.isHidden = false
        searchBySpeciality.setTitle("Srarch", for: .normal)
        //performSegue(withIdentifier: "GoToSearchReasult", sender: self)
        
    }
    
    
    
   
    
    @IBAction func searchByName(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToSearchReasult", sender: self)
        
    }
    
    
    
    
    // ///////////////////////////////
   
    var doctorInfoArray = [DoctorInfo]()
    func getDoctorInfo(){
        
        let DoctorDB = Database.database().reference().child("DoctorInfo/profile")
        DoctorDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String , Any>
            let doctor = DoctorInfo()
            
            doctor.sender = snapshotValue["sender"] as! String
            doctor.Name = snapshotValue["name"] as! String
            doctor.Speciality = snapshotValue["speciality"] as! String
            doctor.PhoneNumber = snapshotValue["phoneNum"] as! String
            doctor.Address = snapshotValue["address"] as! String
            doctor.profileImageUrl = snapshotValue["profilePhoto"] as! String
            doctor.Fees = snapshotValue["fees"] as! String
            
            self.doctorInfoArray.append(doctor)
            print(self.doctorInfoArray.count)
            do {
                try self.realm.write{
                    self.realm.add(self.doctorInfoArray)
                }
            }catch{
                print("error save data to realm\(error)")
            }
        }
        
    }
    
    
    
    
    
    
}
