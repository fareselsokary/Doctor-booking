//
//  SearchViewController.swift
//  Doctor booking
//
//  Created by fares elsokary on 10/7/18.
//  Copyright © 2018 FaresElsokary. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift
class SearchResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let realm = try! Realm()
    
    var ResultArray : Results<DoctorInfo>?

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var topConstrain: NSLayoutConstraint!
    var searchBarIsHidden = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(ResultArray![0].Address)
       let nibCell = UINib(nibName: "DoctorProfileCellTableViewCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "DoctorCell")
        if searchBarIsHidden == true{
            topConstrain.constant = 0
            searchBar.isHidden = true
        }else{
            topConstrain.constant = 56
            searchBar.isHidden =  false
        }
    }
    
   
     func viewDidappear(){
        tableView.reloadData()
    }
    
    

    @IBAction func signOutButtonPressed(_ sender: Any) {
        do{
       try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        }catch{
            print("error signOut \(error)")
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ResultArray?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorCell", for: indexPath) as! DoctorProfileCellTableViewCell
        
        cell.GetDoctorInfo(name: ResultArray![indexPath.row].Name, specialty: ResultArray![indexPath.row].Speciality, address: ResultArray![indexPath.row].Address, fees: ResultArray![indexPath.row].Fees)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 178
    }
    

   
}
