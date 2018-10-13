//
//  GradiantView.swift
//  Doctor booking
//
//  Created by fares elsokary on 10/7/18.
//  Copyright © 2018 FaresElsokary. All rights reserved.
//

import UIKit
@IBDesignable
class GradiantView: UIView {

    @IBInspectable var FirstColor : UIColor = UIColor.clear{
        didSet{
            updateView()
        }
    }
    
    
    @IBInspectable var SecondColor : UIColor = UIColor.clear{
        didSet{
            updateView()
        }
    }
    
    
    
    override class var layerClass : AnyClass{
        get{
            return CAGradientLayer.self
        }
    }
    func updateView(){
        let layers = self.layer as! CAGradientLayer
        layers.colors = [FirstColor.cgColor ,SecondColor.cgColor]
    }
}
