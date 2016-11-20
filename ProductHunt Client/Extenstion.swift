////
////  Extenstion.swift
////  ProductHunt Client
////
////  Created by Ilya Shigabeev on 20.11.16.
////  Copyright © 2016 Ilya Shigabeev. All rights reserved.
////
//
//import UIKit
//
//public extension UIView {
//    
//    @IBInspectable var roundRadius : CGFloat {
//        get{
//            return self.layer.cornerRadius
//        }
//        set{
//            self.clipsToBounds = true
//            self.layer.cornerRadius = newValue
//            self.layer.masksToBounds = true 
//        } 
//    } 
//    
//}
//
//public extension UIView {
//    
//    @IBInspectable var shadowRadius : CGFloat {
//        get{
//            return self.layer.shadowRadius
//        }
//        set{
//            self.clipsToBounds = false
//            self.layer.shadowRadius = newValue
//            self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//            self.layer.masksToBounds = false
//        }
//    }
//    
//    @IBInspectable var shadowColor : UIColor? {
//        get{
//            return UIColor(cgColor: self.layer.shadowColor! )
//        }
//        set{
//            self.layer.shadowColor = newValue?.cgColor
//        }
//    }
//    
//    @IBInspectable var shadOpacity : Float {
//        get{
//            return self.layer.shadowOpacity
//        }
//        set{
//            self.layer.shadowOpacity = newValue 
//        } 
//    } 
//    
//    @IBInspectable var shadowOffset : CGSize { 
//        get{ 
//            return self.layer.shadowOffset 
//        } 
//        set{ 
//            self.layer.shadowOffset = newValue 
//        } 
//    } 
//}
