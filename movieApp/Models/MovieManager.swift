//
//  MovieManager.swift
//  movieApp
//
//  Created by Mustafa on 3.03.2022.
//

import Foundation

protocol MovieManagerDelegate {
    
    func didUpdateMovie(movie: MovieModel)
    func didFailWithError(_ error: Error)
}

struct MovieManager {
    
    var delegate: MovieManagerDelegate?

    func performRequest(with urlString: String) {
        
        //1.Create url
        if let url = URL(string: urlString) {
            
            //2.Create a urlSession
            let session = URLSession(configuration: .default)
            
            //3.Give the session task
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    print(error!.localizedDescription)
                    
                    return
                }
                if let safeData = data {
                    
                    if let movie = self.parseJSON(movieData: safeData) {
                        self.delegate?.didUpdateMovie(movie: movie)
                    }
                }
            }
            //4.Start the task
            task.resume()
        }
    }
    
    func parseJSON(movieData: Data) -> MovieModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(MovieModel.self, from: movieData)
            
            let movie = MovieModel(page: decodedData.page, results: decodedData.results, total_pages: decodedData.total_pages, total_results: decodedData.total_results)
            
            return movie
        } catch  {
            print(error.localizedDescription)
            return nil
        }
    }
}
