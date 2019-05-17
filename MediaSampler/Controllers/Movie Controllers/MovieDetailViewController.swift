//
//  MovieDetailViewController.swift
//  MediaSampler
//
//  Created by Marquis Dennis on 5/16/19.
//  Copyright © 2019 MDennis. All rights reserved.
//

import UIKit

class MovieDetailViewController: UITableViewController {
  @IBOutlet weak var movieImageView: UIImageView!
  @IBOutlet weak var lblYear: UILabel!
  @IBOutlet weak var lblRating: UILabel!
  @IBOutlet weak var lblRuntime: UILabel!
  @IBOutlet weak var btnPlay: UIButton!
  
  // MARK: - Properties
  fileprivate var movie: Movie? {
    didSet {
      populateDetailSubViews()
    }
  }
  
  var movieId: Int64?
  
  fileprivate lazy var titleLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  // MARK: - ViewController Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    //load data from realm, core data or local cache
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.loadMovie()
  }

  // MARK: - Helpers
  fileprivate func exitOnError() {
    UIUtils.displayBasicAlertAction(onViewController: self, withTitle: "Movie Error", message: "Unable to retrieve movie details.", completionHandler: { action in
      DispatchQueue.main.async {
        self.navigationController?.popViewController(animated: true)
      }
    })
  }
  
  fileprivate func loadMovie() {
    guard let movieId = self.movieId else {
      exitOnError()
      return
    }
    
    MovieManager.shared.get(movieWithId: movieId) { [weak self] result in
      guard let strongSelf = self else {
        self?.exitOnError()
        return
      }
      
      switch result {
      case .success(let movie):
        strongSelf.movie = movie
          // TODO: (Update cache) Store data in core data or realm
      case .failure(let error):
        print(error as Any)
        strongSelf.exitOnError()
      }
    }
  }
  
  ///
  /// Addoitional initial layout details of subviews.
  ///
  fileprivate func setupViews() {
    btnPlay.layer.cornerRadius = 8
    
    let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width - 32, height: view.frame.height))
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
    label.textAlignment = .center
    label.numberOfLines = 2
    self.navigationItem.titleView = label
  }
  
  /// Setup detail subviews with movie details.
  fileprivate func populateDetailSubViews() {
    lblYear.text = "\(movie?.year ?? 0)"
    
    
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 0
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return 0
  }
}
