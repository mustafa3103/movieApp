//
//  UpcomingViewController.swift
//  movieApp
//
//  Created by Mustafa on 8.03.2022.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    //MARK: - Variables
    var movieManager = MovieManager()
    var movieModel: MovieModel?
    var showMovie: Result?
    var detailIndex: Int?
    
    //MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Tableview settings
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        movieManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Movie API
        movieManager.performRequest(with: K.API.upcomingMovies)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        if let movieModel = movieModel {
            if let movie = movieModel.results {
                if let randomMovie = movie.randomElement() {
                    if let rMovie = randomMovie.backdrop_path {
                        let imageUrl = "\(K.API.pictures)" + rMovie
                        
                        imageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieModel = movieModel {
            if let result = movieModel.results {
                if let index = detailIndex {
                    if segue.identifier == K.toDetailVC {
                        let destinationVC = segue.destination as! DetailViewController
                        let movie = result[index]
                        
                        destinationVC.movieName = movie.title
                        destinationVC.movieSubject = movie.overview
                        destinationVC.imdb = movie.vote_average
                        destinationVC.movieImageUrl = "\(K.API.pictures)" + movie.backdrop_path!
                    }
                }
            }
        }
    }
}
//MARK: - TableView dataSource methods
extension UpcomingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var movieCount = 1
        
        if let movies = movieModel?.results?.count {
            movieCount = movies
        }else {
            //Show error
        }
        return movieCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! CustomCell
        cell.customTableCellDelegate = self
        cell.showInformation.tag = indexPath.row
        if let movieModel = movieModel {
            if let movies = movieModel.results {
                showMovie = movies[indexPath.row]
                
                if let show = showMovie {
                    let imageUrl = "\(K.API.pictures)" + show.backdrop_path!
                    
                    cell.cellImage.sd_setImage(with: URL(string: imageUrl), completed: nil)
                    
                    cell.movieNameLabel.text = show.title
                    cell.imdbLabel.text = "Imdb: \(show.vote_average ?? 0.0)"
                }
            }
        }
        return cell
    }
}
//MARK: - MovieManagerDelegate
extension UpcomingViewController: MovieManagerDelegate {
    
    func didFailWithError(_ error: Error) {
        print("Error")
    }
    func didUpdateMovie(movie: MovieModel) {
        
        movieModel = movie
    }
}

extension UpcomingViewController: CustomTableCellDelegate {
    func btnClicked(tag: Int) {
        
        if showMovie != nil {
            print("index: \(tag)")
            detailIndex = tag
            performSegue(withIdentifier: K.toDetailVC, sender: nil)
        }
    }
}
