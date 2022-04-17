//
//  Utlis.swift
//  IMDBProject
//
//  Created by Yakup Demir on 16.04.2022.
//

import Foundation

class Utils {
    static let instance = Utils()
    
    func imageBaseUrl() -> String{
        return "https://image.tmdb.org/t/p/w500"
    }
    func getApiKey() -> String {
        return "a0bcd10289e97751f481684930c40b49"
    }
}
