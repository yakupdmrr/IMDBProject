//
//  UpcomingMovieManager.swift
//  IMDBProject
//
//  Created by Yakup Demir on 16.04.2022.
//

import Foundation

class MovieManager: NSObject {
    static let instance = MovieManager()

    private var imdbModel: AlamofireManager<ImdbModel> = AlamofireManager<ImdbModel>()
    private var movieModel : AlamofireManager<Movie> = AlamofireManager<Movie>()

    func getUpcomingMovie(page: Int, apiKey: String, completionHandler: @escaping (_ status: Bool ,ImdbModel) -> Void) {
        let serviceUrl = "\(RestApiPath.instance.getUpcomingUrl(apiKey: apiKey))&page=\(String(page))"
        var status = false
        imdbModel.getAllData(servicePath: serviceUrl) { response in
            status = true
            completionHandler(status,response)
        } onFail: { error in
            AlertManager.instance.showErrorMessage(title: "Upcoming Movie Error", messsage: error?.debugDescription, complation: nil)
        }
    }
    func getNowPlayingMovie(apiKey: String, completionHandler: @escaping (_ status: Bool,ImdbModel) -> Void) {
        var status = false
        imdbModel.getAllData(servicePath: RestApiPath.instance.getNowPlaying(apiKey: apiKey)) { response in
            status = true
            completionHandler(status,response)
        } onFail: { error in
            AlertManager.instance.showErrorMessage(title: "Now Playing Movie Error", messsage: error?.debugDescription, complation: nil)
        }
    }
    func getMovie(id : Int,apiKey: String, completionHandler: @escaping (_ status: Bool,Movie) -> Void){
        var status = false
        movieModel.getAllData(servicePath: RestApiPath.instance.getMovie(id: id, apiKey: apiKey)) { response in
            status = true
            completionHandler(status,response)
        } onFail: { error in
            AlertManager.instance.showErrorMessage(title: "Get Movie Error", messsage: error?.debugDescription, complation: nil)
        }

    }
}
