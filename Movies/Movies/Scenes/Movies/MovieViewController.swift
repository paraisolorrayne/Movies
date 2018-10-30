//
//  MovieViewController.swift
//  Movies
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright (c) 2018 Lorrayne Paraiso. All rights reserved.
//
//  This file was generated by the Clean Swift HELM Xcode Templates
//  https://github.com/HelmMobile/clean-swift-templates

import UIKit

protocol MovieViewControllerInput {
    
}

protocol MovieViewControllerOutput {
    
}

class MovieViewController: UIViewController, MovieViewControllerInput {

    // MARK: Properties

    var output: MovieViewControllerOutput?
    var router: MovieRouter?
    var moviesVM: MoviesViewModel = MoviesViewModel()
    var loadingMore: Bool = false
    private var loadingPlaceholder = true
    var searchController : UISearchController!

    // MARK: IBOutlet

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        MovieConfigurator.sharedInstance.configure(viewController: self)
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesVM.delegate = self
        setupSearchBar()
        fillTableUsingPlaceholder {
            self.moviesVM.loadMovies { () in
                self.loadingPlaceholder = false
                self.tableView.reloadData()
            }
        }

    }
    
    // MARK: Requests

    func fillTableUsingPlaceholder(done:@escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            done()
        }
    }

    // MARK: Display logic

    // MARK: Configuration

    private func setupSearchBar() {
        searchController = UISearchController(searchResultsController:  nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "touch for search zombies or movies"
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        
        self.definesPresentationContext = true
        
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = searchController
            self.navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            self.navigationItem.titleView = searchController.searchBar
        }
    }
}

//This should be on configurator but for some reason storyboard doesn't detect ViewController's name if placed there
extension MovieViewController: MoviePresenterOutput {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router?.passDataToNextScene(for: segue)
    }
}

// This response is called after the page request
extension MovieViewController: AsyncResponse {
    func doneLoadMoreMovies() {
        self.tableView.reloadData()
    }
}

extension MovieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(searchBar)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        search(searchBar)
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func search(_ searchBar: UISearchBar) {
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return loadingPlaceholder ? 5 : moviesVM.countMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MovieTableViewCell!
        if loadingPlaceholder {
            let placeholder = tableView.dequeueReusableCell(withIdentifier: "moviecellplaceholder", for: indexPath)
            guard let placeHolderCell = placeholder as? MovieTableViewCell else {
                fatalError("Could not deque cell moviecellplaceholder")
            }
            cell = placeHolderCell
        } else {
            let movie = tableView.dequeueReusableCell(withIdentifier: "\(MovieTableViewCell.self)", for: indexPath)
            guard let movieCell = movie as? MovieTableViewCell else {
                fatalError("Could not deque cell \(MovieTableViewCell.self)")
            }
            if let movie = moviesVM.movieAtIndex(indexPath.row) {
                movieCell.movie = movie
                if indexPath.row % 2 > 0 {
                    movieCell.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
                } else {
                    movieCell.backgroundColor = UIColor.white
                }
            }
            cell = movieCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if loadingPlaceholder {
            tableView.deselectRow(at: indexPath, animated: false)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
            let data = moviesVM.movieAtIndex(indexPath.row)
            performSegue(withIdentifier: "segueMovieDetails", sender: data)
        }
    }
}
