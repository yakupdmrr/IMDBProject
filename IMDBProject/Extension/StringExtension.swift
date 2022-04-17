//
//  StringExtension.swift
//  IMDBProject
//
//  Created by Yakup Demir on 17.04.2022.
//

import Foundation

extension String {
    
    func formatDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let date = formatter.date(from: self)
        formatter.dateFormat = "dd.MM.yyyy"
        guard let date = date else {
            return self
        }

        let stringDate = formatter.string(from: date)
        return stringDate
    }
    
}
