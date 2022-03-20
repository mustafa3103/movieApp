//
//  RandomMovieViewController.swift
//  movieApp
//
//  Created by Mustafa on 23.02.2022.
//

import UIKit
import SDWebImage

class RandomMovieViewController: UIViewController {

    //MARK: - Variables
    var movieManager = MovieManager()
    var movieModel: MovieModel?
    var mName: String?
    var mSubject: String?
    var mRate: Double?
    var mUrl: String?
    
    //MARK: - Outlets
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieSubject: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieName.text = "Movie name is: \(mName ?? "")"
        movieSubject.text = "Subject is: \(mSubject ?? "")"
        movieRate.text = "Imdb: \(mRate ?? 0.0)"
        movieImage.sd_setImage(with: URL(string: mUrl!), completed: nil)
    }
}
