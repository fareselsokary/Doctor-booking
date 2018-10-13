//
//  ImageBorder.swift
//  Doctor booking
//
//  Created by fares elsokary on 10/8/18.
//  Copyright © 2018 FaresElsokary. All rights reserved.
//

import UIKit

class ImageBorder: UIImageView {
   
    @IBInspectable var CornerRadius_1 :CGFloat = 0{
        didSet{
            self.clipsToBounds = true
            self.layer.cornerRadius = frame.size.width/CornerRadius_1
            
        }
    }
    
    
}
