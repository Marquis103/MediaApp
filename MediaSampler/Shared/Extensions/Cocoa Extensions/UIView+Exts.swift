//
//  UIView+Exts.swift
//  MediaSampler
//
//  Created by Marquis Dennis on 5/16/19.
//  Copyright © 2019 MDennis. All rights reserved.
//

import UIKit

extension UIView {
  ///
  /// Adds view constraints using markup language.
  ///
  func addConstraints(withFormat formatString: String, forViews views: UIView...) {
    var viewDictionary = [String: UIView]()
    for (index, view) in views.enumerated() {
      let key = "v\(index)"
      view.translatesAutoresizingMaskIntoConstraints = false
      viewDictionary[key] = view
    }
    
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: formatString,
                                                  options: .init(),
                                                  metrics: nil,
                                                  views: viewDictionary))
  }
}
