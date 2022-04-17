//
//  UIViewControllerExtension.swift
//  IMDBProject
//
//  Created by Yakup Demir on 15.04.2022.
//

import Foundation

import UIKit


extension UIViewController  {
    
    class func loadFromNib<T: UIViewController>() -> T {
        return T(nibName: String(describing: self.description().split(separator: ".")[1]), bundle: nil)
    }
    
    func pushVC(controller: UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func popToVC(toClass: AnyClass? = nil, toClassName: String? = nil) -> Bool {
        
        if let navigationController = navigationController {
            
            for vc in navigationController.viewControllers {
                var found = false
                print(NSStringFromClass(vc.classForCoder))
                if let toClass = toClass, vc.isKind(of: toClass) {
                    found = true
                }
                else if let toClassName = toClassName, NSStringFromClass(vc.classForCoder) == toClassName {
                    found = true
                }
                
                if found {
                    navigationController.popToViewController(vc, animated: true)
                    return true
                }
            }
        }
        return false
    }
    
    func presentVC(controller: UIViewController) {
        //controller.modalPresentationStyle = .fullScreen -- gerekli yerlerde kullanılabilir.
        self.present(controller, animated: true, completion: nil)
    }
    
    func dissmiss() {
        self.dismiss(animated: true) {
            
        }
    }
    
}

