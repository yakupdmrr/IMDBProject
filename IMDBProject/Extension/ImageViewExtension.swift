//
//  ImageViewExtension.swift
//  IMDBProject
//
//  Created by Yakup Demir on 16.04.2022.
//

import Foundation
import UIKit

extension UIImageView {
    @IBInspectable var cornerRadius:CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
        }
    }
}

