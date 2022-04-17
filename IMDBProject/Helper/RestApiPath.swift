//
//  RestApiPath.swift
//  IMDBProject
//
//  Created by Yakup Demir on 16.04.2022.
//

import Foundation

class RestApiPath {
    static let instance = RestApiPath()

    let baseUrl = "https://api.themoviedb.org/3/movie/"

    // MainList Endpoint
    func getUpcomingUrl(apiKey: String) -> String {
        return baseUrl + "upcoming?api_key=" + apiKey
    }
    //SliderList Endpoint
    func getNowPlaying(apiKey : String) -> String {
        return baseUrl + "now_playing?api_key=" + apiKey
    }
    
    func getMovie(id : Int, apiKey: String) -> String{
        return baseUrl + String(id) + "?api_key=" + apiKey
    }
}
