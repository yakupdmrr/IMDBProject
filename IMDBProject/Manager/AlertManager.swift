//
//  AlertManager.swift
//  IMDBProject
//
//  Created by Yakup Demir on 17.04.2022.
//

import Foundation
import CDAlertView

class AlertManager : NSObject {
    static let instance = AlertManager()

    func showWarningMessage(title: String = "Uyarı", messsage: String? = nil, complation: (() -> Void)? = nil) {
        
        let alert = CDAlertView(title: title, message: messsage, type: CDAlertViewType.warning)
        alert.add(action: CDAlertViewAction(title: "Tamam", handler: { _ in
            if complation != nil {
                complation!()
            }
            return true
        }))
        alert.show()
    }
    
    func showSuccessMessage(title: String = "Başarılı", messsage: String? = nil, complation: (() -> Void)? = nil) {
        
        let alert = CDAlertView(title: title, message: messsage, type: CDAlertViewType.success)
        alert.add(action: CDAlertViewAction(title: "Tamam", handler: { _ in
            if complation != nil {
                complation!()
            }
            return true
        }))
        alert.show()
    }
    
    func showErrorMessage(title: String = "Hata", messsage: String? = nil, complation: (() -> Void)? = nil) {
        
        let alert = CDAlertView(title: title, message: messsage, type: CDAlertViewType.error)
        alert.add(action: CDAlertViewAction(title: "Tamam", handler: { _ in
            if complation != nil {
                complation!()
            }
            return true
        }))
        alert.show()
    }
    
}
