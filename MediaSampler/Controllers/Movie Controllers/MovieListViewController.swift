//
//  ViewController.swift
//  MediaSampler
//
//  Created by Marquis Dennis on 5/15/19.
//  Copyright © 2019 MDennis. All rights reserved.
//

import UIKit

class MovieListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  //movie array
  var movies: [Movie] = [] {
    didSet {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  fileprivate var refreshControl: UIRefreshControl?
  
  // MARK: - View Controller Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    
    collectionView.alwaysBounceVertical = true
    collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.contentInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 8.0, right: 16.0)
    collectionView.collectionViewLayout.shouldInvalidateLayout(forBoundsChange: collectionView.bounds)
    
    //add collection view refresh control
    refreshControl = UIRefreshControl()
    refreshControl?.addTarget(self, action: #selector(onRefresh(_:)), for: .valueChanged)
    collectionView.refreshControl = refreshControl
    
    let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width - 32, height: view.frame.height))
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
    label.text = "Movies"
    label.textAlignment = .center
    self.navigationItem.titleView = label
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    //TODO: Load data from core data, realm or local db cache
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.onRefresh(nil)
  }
  
  // MARK: - Helpers
  
  @objc func onRefresh(_ sender: UIRefreshControl?) {
    self.loadMovies()
  }
  
  ///
  /// Loads movie list.
  ///
  fileprivate func loadMovies() {
    MovieManager.shared.getCollection { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case .success(let movies):
        self?.movies = movies
        // TODO: Store data in core data
        // TODO: Reload collection view
        DispatchQueue.main.async {
          if let control = self?.refreshControl, control.isRefreshing {
            self?.endRefresh(onControl: control)
          }
        }
        break
      case .failure(let error):
        print(error as Any)
        UIUtils.displayBasicAlertAction(onViewController: strongSelf, withTitle: "Movie Error", message: "Unable to retrieve movie list.  Please try again.")
        break
      }
    }
  }
  
  // MARK: - CollectionView and FlowLayoutDelegate
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell
    cell?.movie = movies[indexPath.item]
    return cell ?? UICollectionViewCell()
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width: CGFloat = (view.frame.width - 32.0) / 3.2
    return CGSize(width: width, height: view.frame.height * 0.40)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 8.0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 4.0
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }
}
