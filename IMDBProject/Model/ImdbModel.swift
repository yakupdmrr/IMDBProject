//
//  ImdbModel.swift
//  IMDBProject
//
//  Created by Yakup Demir on 16.04.2022.
//

import Foundation

struct ImdbModel : Codable {
    var dates: Dates?
    var page: Int?
    var results: [Movie]?
    var total_pages: Int?
    var total_results: Int?
}
