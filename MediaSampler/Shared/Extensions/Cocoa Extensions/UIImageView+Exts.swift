//
//  UIImageView+Exts.swift
//  MediaSampler
//
//  Created by Marquis Dennis on 5/16/19.
//  Copyright © 2019 MDennis. All rights reserved.
//

import UIKit

extension UIImageView {
  ///
  /// Asynchronously set imageView to image data contained at provided URL.
  ///
  /// Parameters:
  ///   - `url`: Url of image
  ///
  func setImage(fromURL url: URL) {
    DispatchQueue.global(qos: .userInteractive).async {
      if let imagedata = try? Data(contentsOf: url) {
        DispatchQueue.main.async {
          self.image = UIImage(data: imagedata)
        }
      }
    }
  }
}
