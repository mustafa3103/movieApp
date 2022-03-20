//
//  MainViewController.swift
//  movieApp
//
//  Created by Mustafa on 22.02.2022.
//

import UIKit
import SideMenu
import SDWebImage
import Firebase
class MainViewController: UIViewController {
   
   //MARK: - Variables
   private var sideMenu: SideMenuNavigationController?
   private var movieManager = MovieManager()
   private var movieModel: MovieModel?
   private var showMovie: Result?
   private var detailIndex: Int?
   
   //MARK: - Outlets
   @IBOutlet weak var mainTableView: UITableView!
   @IBOutlet weak var tabBar: UITabBar!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      //Menu
      let menu = MenuController(with: ["Random Movie","Upcoming Movies", "Exit Account"])
      menu.delegate = self
      sideMenu =  SideMenuNavigationController(rootViewController: menu)
      sideMenu?.leftSide = false
      SideMenuManager.default.rightMenuNavigationController = sideMenu
      SideMenuManager.default.addPanGestureToPresent(toView: view)
      
      navigationItem.hidesBackButton = true
      
      //TableView
      mainTableView.dataSource = self
      mainTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
      
      //MovieManager Delegate
      movieManager.delegate = self
      
   }
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      //Movie API
      movieManager.performRequest(with: K.API.topRatedMoveies)
   }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      mainTableView.reloadData()
   }
   
   //MARK: - Buttons
   @IBAction func didTapMenuButton(_ sender: UIBarButtonItem) {
      present(sideMenu!, animated: true)
   }
   
   //MARK: - Prepare segue
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
      if let movieModel = movieModel {
         if let result = movieModel.results {
            let randomMovie = result.randomElement()
            
            if segue.identifier == K.toDetailVC {
               let destinationVC = segue.destination as! DetailViewController
               if let detailIndex = detailIndex {
                  let movie = result[detailIndex]
                  destinationVC.movieName = movie.title
                  destinationVC.movieSubject = movie.overview
                  destinationVC.imdb = movie.vote_average
                  destinationVC.movieImageUrl = "\(K.API.pictures)" + movie.backdrop_path!
                  
               }
            }
            
            if let randomMovie = randomMovie {
               let name = randomMovie.title
               let imdb = randomMovie.vote_average
               let subject = randomMovie.overview
               let imageUrl = "\(K.API.pictures)" + randomMovie.backdrop_path!
               
               if segue.identifier == K.randomMovieSegue {
                  let destinationVC = segue.destination as! RandomMovieViewController
                  
                  destinationVC.mName = name
                  destinationVC.mSubject = subject
                  destinationVC.mRate = imdb
                  destinationVC.mUrl = imageUrl
               }
            }
         }
      }
   }
}
//MARK: - TableView datasource methods
extension MainViewController: UITableViewDataSource {
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
      
      if let movies = movieModel {
         if let movie = movies.results {
            showMovie = movie[indexPath.row]
            
            if let show = showMovie {
               let imageUrl = "\(K.API.pictures)" + show.backdrop_path!
               
               cell.cellImage.sd_setImage(with: URL(string: imageUrl), completed: nil)
               cell.movieNameLabel.text = show.title
               cell.imdbLabel.text = "IMDB: \(show.vote_average ?? 0.0)"
            }
         }
      }
      return cell
   }
}

//MARK: - MovieManagerDelegate
extension MainViewController: MovieManagerDelegate {
   
   func didFailWithError(_ error: Error) {
      print("Error")
   }
   
   func didUpdateMovie(movie: MovieModel) {
      
      movieModel = movie
   }
}

//MARK: - Menu Delegate
extension MainViewController: MenuControllerDelegate {
   
   func didSelectMenuItem(named: String) {
      
      sideMenu?.dismiss(animated: true, completion: {
         if named == "Random Movie" {
            //Go Random Movie
            self.performSegue(withIdentifier: K.randomMovieSegue, sender: nil)
         }else if named == "Upcoming Movies" {
            self.performSegue(withIdentifier: K.upcomingSegue, sender: nil)
         }else if named == "Exit Account" {
            //Exit account.
            let alert = UIAlertController(title: "Exit Account", message: "Are you sure", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) { UIAlertAction in
               //Exit account from firebase !!!
               
               do {
                  try Auth.auth().signOut()
                  self.navigationController?.popToRootViewController(animated: true)
               } catch {
                  //Show error
               }
            }
            let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            
            //Ok butonunu uyarı mesajımıza ekleme
            alert.addAction(okButton)
            alert.addAction(cancelButton)
            //Uyarı mesajını gösterme
            self.present(alert, animated: true, completion: nil)
         }
      })
   }
}

extension MainViewController: CustomTableCellDelegate {
   func btnClicked(tag: Int) {
      if showMovie != nil {
         detailIndex = tag
         performSegue(withIdentifier: K.toDetailVC, sender: nil)
      }
   }
}
