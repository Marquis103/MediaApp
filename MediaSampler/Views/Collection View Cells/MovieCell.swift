//
//  MovieCell.swift
//  MediaSampler
//
//  Created by Marquis Dennis on 5/16/19.
//  Copyright © 2019 MDennis. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
  static let reuseIdentifier = "movieListViewCell"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(thumbNail)
    addSubview(title)
    addSubview(artistNames)
    
    thumbNail.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    thumbNail.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    thumbNail.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
    thumbNail.widthAnchor.constraint(equalToConstant: 90.0).isActive = true
    title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    title.topAnchor.constraint(equalTo: thumbNail.bottomAnchor, constant: 1.0).isActive = true
    title.heightAnchor.constraint(lessThanOrEqualToConstant: 100.0).isActive = true
    artistNames.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    artistNames.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 1.0).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var movie: Movie? {
    didSet {
      title.text = movie?.title ?? nil
      artistNames.text = movie?.artistNames ?? nil//movie?.artistNames?.joined(separator: ",") ?? nil
      
      if let imageURL = movie?.image {
        thumbNail.setImage(fromURL: imageURL)
      } else {
        thumbNail.image = nil
      }
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    movie = nil
  }
  
  fileprivate let thumbNail: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  fileprivate let title: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  fileprivate let artistNames: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
}
