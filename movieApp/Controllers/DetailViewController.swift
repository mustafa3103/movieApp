//
//  DetailViewController.swift
//  movieApp
//
//  Created by Mustafa on 23.02.2022.
//

import UIKit
import SDWebImage
class DetailViewController: UIViewController {
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieSubjectLabel: UILabel!
    @IBOutlet weak var imbdLabelDV: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    var movieName: String?
    var movieSubject: String?
    var imdb: Double?
    var movieImageUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movieName = movieName, let movieSubject = movieSubject, let imdb = imdb, let movieImageUrl = movieImageUrl {
            movieNameLabel.text = movieName
            movieSubjectLabel.text = movieSubject
            imbdLabelDV.text = "Imdb: \(imdb)"
            movieImageView.sd_setImage(with: URL(string: movieImageUrl))
        }
    }
}
