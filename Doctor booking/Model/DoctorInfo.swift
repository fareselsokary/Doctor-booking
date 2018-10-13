//
//  DoctorInfo.swift
//  Doctor booking
//
//  Created by fares elsokary on 10/8/18.
//  Copyright © 2018 FaresElsokary. All rights reserved.
//

import Foundation
import RealmSwift

class DoctorInfo : Object{
   @objc dynamic var Name : String = ""
   @objc dynamic  var Speciality : String = ""
   @objc dynamic var PhoneNumber : String = ""
   @objc dynamic  var Address : String = ""
   @objc dynamic var Fees : String = ""
   @objc dynamic var profileImageUrl : String = ""
   @objc dynamic var sender : String = ""
    
   
    
    func putData(name : String, speciality : String, address :String, fees : String) {
        self.Name = name
        self.Speciality = speciality
        self.Address = address
        self.Fees = fees
    }
}
