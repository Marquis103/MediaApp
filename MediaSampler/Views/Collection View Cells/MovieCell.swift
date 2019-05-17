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
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(thumbNail)
    addSubview(title)
    addSubview(artistNames)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Cell Maintenance
  override func layoutSubviews() {
    super.layoutSubviews()
    
    thumbNail.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    thumbNail.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.60).isActive = true
    thumbNail.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    
    title.topAnchor.constraint(equalToSystemSpacingBelow: thumbNail.bottomAnchor, multiplier: 1.5).isActive = true
    title.leadingAnchor.constraint(equalTo: thumbNail.leadingAnchor).isActive = true
    title.trailingAnchor.constraint(equalTo: thumbNail.trailingAnchor).isActive = true
    
    artistNames.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 1.5).isActive = true
    artistNames.leadingAnchor.constraint(equalTo: thumbNail.leadingAnchor).isActive = true
    artistNames.trailingAnchor.constraint(equalTo: thumbNail.trailingAnchor).isActive = true
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    movie = nil
  }
  
  // MARK: - Cell Properties
  var movie: Movie? {
    didSet {
      title.text = movie?.title ?? nil
      artistNames.text = movie?.artistNames ?? nil
      
      if let imageURL = movie?.image {
        thumbNail.setImage(fromURL: imageURL)
      } else {
        thumbNail.image = nil
      }
    }
  }

  fileprivate let thumbNail: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = ContentMode.scaleToFill
    return imageView
  }()
  
  fileprivate let title: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
    label.textAlignment = .center
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.2
    return label
  }()
  
  fileprivate let artistNames: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.lineBreakMode = .byWordWrapping
    label.font = UIFont.systemFont(ofSize: 12.0, weight: .light)
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
  }()
}
