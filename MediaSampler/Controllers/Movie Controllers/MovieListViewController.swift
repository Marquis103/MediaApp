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
  
  // MARK: - View Controller Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "movieListViewCell")
    
    //collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
    collectionView.contentInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 8.0, right: 16.0)
    
    var label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width - 32, height: view.frame.height))
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 20.0)
    label.text = "Movies"
    self.navigationItem.titleView = label
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    //TODO: Load data from core data or local db cache
  }
  
//  override func viewWillLayoutSubviews() {
//    super.viewWillLayoutSubviews()
//
//    collectionView.collectionViewLayout.invalidateLayout()
////    collectionView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
////    collectionView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
////    collectionView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
////    collectionView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
//    MovieManager.shared.getCollection { [weak self] result in
//      guard let strongSelf = self else { return }
//      switch result {
//      case .success(let movies):
//        self?.movies = movies
//
//        // TODO: Store data in core data
//        // TODO: Reload collection view
//        break
//      case .failure(let error):
//        print(error as Any)
//        UIUtils.displayBasicAlertAction(onViewController: strongSelf, withTitle: "Movie Error", message: "Unable to retrieve movie list.  Please try again.")
//        break
//      }
//    }
  }
  
  // MARK: - CollectionView and FlowLayoutDelegate
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell
//    cell?.movie = movies[indexPath.item]
//    return cell ?? UICollectionViewCell()
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieListViewCell", for: indexPath)
    cell.backgroundColor = .black
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width: CGFloat = (view.frame.width - 32.0) / 2.1
    return CGSize(width: width, height: view.frame.height * 0.35)
  }
//
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//    return 8.0
//  }
//
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//    return 8.0
//  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20//movies.count
  }
}
