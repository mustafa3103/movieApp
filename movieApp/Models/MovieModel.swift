//
//  MovieModel.swift
//  movieApp
//
//  Created by Mustafa on 5.03.2022.
//

import Foundation


var movieModel: MovieModel?

struct movieModelArray: Codable {
    var modelArray: [MovieModel]? = []
}

struct MovieModel: Codable {
    var page: Int? = 1
    var results: [Result]? = []
    var total_pages: Int? = 0
    var total_results: Int? = 0
}

struct Result: Codable {
    var adult: Bool? = false
    var backdrop_path: String? = ""
    var genre_ids: [Int]? = []
    var id: Int? = 0
    var original_language: String? = "en"
    var original_title: String? = ""
    var overview: String? = ""
    var popularity: Double? = 0.0
    var poster_path: String? = ""
    var release_date: String? = ""
    var title: String? = ""
    var video: Bool? = false
    var vote_average: Double? = 0.0
    var vote_count: Int? = 0
}
