//
//  MovieDetailViewController.swift
//  MediaSampler
//
//  Created by Marquis Dennis on 5/16/19.
//  Copyright © 2019 MDennis. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class MovieDetailViewController: UITableViewController {
  enum MovieDetailTableViewRows: Int, CaseIterable {
    case image = 0
    case metadata
    case play
    case synopsis
    case cast
    case directors
    case producers
    case writers
  }
  
  @IBOutlet weak var movieImageView: UIImageView!
  @IBOutlet weak var lblYear: UILabel!
  @IBOutlet weak var lblRating: UILabel!
  @IBOutlet weak var lblRuntime: UILabel!
  @IBOutlet weak var btnPlay: UIButton!
  @IBOutlet weak var txtViewSynopsis: UITextView!
  @IBOutlet weak var lblCast: UILabel!
  @IBOutlet weak var lblDirector: UILabel!
  @IBOutlet weak var lblProducers: UILabel!
  @IBOutlet weak var lblWriters: UILabel!
  
  // MARK: - Properties
  fileprivate var movie: Movie? {
    didSet {
      DispatchQueue.main.async {
        self.title = self.movie!.title
        self.setAvailableRows()
      }
    }
  }
  
  var movieId: Int64?
  fileprivate var availableRows: [MovieDetailTableViewRows] = []
  
  // MARK: - ViewController Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    btnPlay.layer.cornerRadius = 8
    
    //removes separator lines
    tableView.separatorStyle = .none
    tableView.tableFooterView = UIView()
    
    tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 8.0, right: 0.0)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    appDelegate.window?.rootViewController?.view.frame = UIScreen.main.bounds
    
    // Hypothetically would update data from API service in `viewDidAppear`
    // while using `viewWillAppear` to update state from realm, coreData or local db cache
    self.loadMovie()
  }

  // MARK: - Helpers
  fileprivate func setAvailableRows() {
    var rows: [MovieDetailTableViewRows] = []
    
    if let image = movie?.image {
      movieImageView.setImage(fromURL: image)
      rows.append(.image)
    }
  
    //metadata
    self.lblYear.text = "\(self.movie?.year ?? 0)"
    self.lblRating.text = "\(self.movie?.rating ?? "Not Available")"
    if let movieDuration = self.movie?.content?.first?.duration?.movieDuration {
      self.lblRuntime.text = "\(movieDuration.hours)h \(movieDuration.minutes)m"
    } else {
      self.lblRuntime.text = "Runtime Not Available"
    }
    
    rows.append(.metadata)
    
    //play button
    rows.append(.play)
    
    if let synopsis = movie?.synopsis {
      self.txtViewSynopsis.text = synopsis
      rows.append(.synopsis)
    }
    
    if let cast = artistListGenerator(artistType: .actor), !cast.isEmpty {
      self.lblCast.text = "Cast: \(cast)"
      rows.append(.cast)
    }
    
    if let directors = artistListGenerator(artistType: .director), !directors.isEmpty {
      self.lblDirector.text = "Directors: \(directors)"
      rows.append(.directors)
    }
    
    if let producers = artistListGenerator(artistType: .producer), !producers.isEmpty {
      self.lblProducers.text = "Producers: \(producers)"
      rows.append(.producers)
    }
    
    if let writers = artistListGenerator(artistType: .writer), !writers.isEmpty {
      self.lblWriters.text = "Writers: \(writers)"
      rows.append(.writers)
    }
    
    self.availableRows = rows
    tableView.reloadData()
  }
  
  ///
  /// Plays apple stream
  ///
  @IBAction func didPressPlayButton(_ sender: UIButton) {
    if let videoURL = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8") {
      let player = AVPlayer(url: videoURL)
      let landscapePlayerViewController = LandscapeViewControllerPlayer()
      landscapePlayerViewController.player = player
      
      //movies should be played in landscape!
      self.present(landscapePlayerViewController, animated: true) {
        landscapePlayerViewController.player?.play()
      }
    }
  }
  
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
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MovieDetailTableViewRows.allCases.count
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let row = MovieDetailTableViewRows.allCases[indexPath.row]
    if availableRows.contains(row) {
      if row == .synopsis {
        return UITableView.automaticDimension
      } else {
        return super.tableView(tableView, heightForRowAt: indexPath)
      }
      
    } else {
      return 0
    }
  }
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.selectionStyle = .none
  }
}

extension MovieDetailViewController {
  ///
  /// Generates UI friendly list of specific artist type if available.
  func artistListGenerator(artistType: ArtistType) -> String? {
    let artistsOfType = self.movie?.artists?.compactMap { $0 }.filter { $0.artistType == artistType }
    let artistNames = artistsOfType?.compactMap { $0.name }.joined(separator: ", ")
    return artistNames
  }
}
