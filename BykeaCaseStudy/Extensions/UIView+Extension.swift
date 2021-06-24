//
//    UIView+Extension.swift
//  BykeaCaseStudy
//
//  Created by Hafiz Saad on 24/06/2021.
//

import UIKit
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//MARK : Extension for UIView
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


extension UIView
{
    @IBInspectable var cornerRadius: CGFloat
    {
        get
        {
            return layer.cornerRadius
        }
        set
        {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat
    {
        get
        {
            return layer.borderWidth
        }
        set
        {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor?
    {
        get
        {
            return UIColor(cgColor: layer.borderColor!)
        }
        set
        {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat
    {
        get
        {
            return layer.shadowRadius
        }
        set
        {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float
    {
        get
        {
            return layer.shadowOpacity
        }
        set
        {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize
    {
        get
        {
            return layer.shadowOffset
        }
        set
        {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor?
    {
        get
        {
            if let color = layer.shadowColor
            {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set
        {
            if let color = newValue
            {
                layer.shadowColor = color.cgColor
            }
            else
            {
                layer.shadowColor = nil
            }
        }
    }
    
    func addShadow()
    {
        self.layer.shadowColor = UIColor.red.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 3.0
    }
    
}
