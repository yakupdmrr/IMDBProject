//
//  ImdbViewModel.swift
//  IMDBProject
//
//  Created by Yakup Demir on 16.04.2022.
//

import Foundation

 struct ImdbListViewModel {
    var movieList = [Movie]()
    func numberOfSection() -> Int {
        return movieList.count
    }

    func movieAtIndex(_ index: Int) -> ImdbViewModel {
        let movie = movieList[index]
        return ImdbViewModel(movie: movie)
    }
    
    
}

struct ImdbViewModel {
    let movie: Movie

    var adult: Bool {
        return movie.adult ?? false
    }

    var backdrop_path: String {
        return movie.backdrop_path ?? "nil backdrop_path"
    }

    var genre_ids: [Int] {
        return movie.genre_ids ?? [Int]()
    }

    var id: Int {
        return movie.id ?? 0
    }

    var original_language: String {
        return movie.original_language ?? "nil original_language"
    }

    var original_title: String {
        return movie.original_title ?? "nil original_title"
    }

    var overview: String {
        return movie.overview ?? "nil overview"
    }

    var popularity: Double {
        return movie.popularity ?? 0.0
    }

    var poster_path: String {
        return movie.poster_path ?? "nil poster_path"
    }

    var release_date: String {
        return movie.release_date ?? "nil release_date"
    }

    var title: String {
        return movie.title ?? "nil title"
    }

    var video: Bool {
        return movie.video ?? false
    }

    var vote_average: Double {
        return movie.vote_average ?? 0.0
    }

    var vote_count: Int {
        return movie.vote_count ?? 0
    }
}
