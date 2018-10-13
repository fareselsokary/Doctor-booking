//
//  DoctorProfileCellTableViewCell.swift
//  Doctor booking
//
//  Created by fares elsokary on 10/11/18.
//  Copyright © 2018 FaresElsokary. All rights reserved.
//

import UIKit

class DoctorProfileCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var DoctorName: UILabel!
    @IBOutlet weak var DoctorSpecialty: UILabel!
    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var Fees: UILabel!
    @IBOutlet weak var OpenTime: UILabel!
    
    @IBOutlet weak var DoctorImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        BackView.layer.cornerRadius = 5
        OpenTime.layer.cornerRadius = 10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func GetDoctorInfo(name : String, specialty : String, address : String, fees : String){
        
        DoctorName.text = name
        
        DoctorSpecialty.text = specialty
        Address.text = address
        Fees.text = fees
       
        
        
    }
    
    
//    func GetDoctorInfo(image : UIImage,name : String, specialty : String, address : String, fees : String, openTime : String){
//
//        DoctorName.text = name
//        DoctorImage.image = image
//        DoctorSpecialty.text = specialty
//        Address.text = address
//        Fees.text = fees
//        OpenTime.text = openTime
//
//
//    }
    
}
