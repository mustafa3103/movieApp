//
//  Constants.swift
//  movieApp
//
//  Created by Mustafa on 24.02.2022.
//

import Foundation
import UIKit

struct K {
    //MARK: - Segue
    static let watchListSegue = "toWatchListVC"
    static let randomMovieSegue = "toRandomMovieVC"
    static let toDetailVC = "toDetailVC"
    static let upcomingSegue = "toUpcomingVC"    
    static let toMainVC = "toMainVC"
    static let reusable = "ReusableCell"
    //MARK: - Colors
    struct Colors {
        static let textColor = UIColor(red: 0.1879999936, green: 0.2779999971, blue: 0.3690000176, alpha: 1)
        static let backgroundColor = UIColor(red: 0.8669999838, green: 0.8669999838, blue: 0.8669999838, alpha: 1)
    }
    //MARK: - API
    struct API {
        static let getPopularMovies = "https://api.themoviedb.org/3/movie/popular?api_key=e9ad9974bb4477e9c820d62531dea375&language=en-US&page=1"
        static let topRatedMoveies = "https://api.themoviedb.org/3/movie/top_rated?api_key=e9ad9974bb4477e9c820d62531dea375&language=en-US&page=1"
        static let upcomingMovies = "https://api.themoviedb.org/3/movie/upcoming?api_key=e9ad9974bb4477e9c820d62531dea375&language=en-US&page=1"
        static let pictures = "https://image.tmdb.org/t/p/w400"
    }
}
