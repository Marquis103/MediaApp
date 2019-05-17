//
//  UIColor+Exts.swift
//  MediaSampler
//
//  Created by Marquis Dennis on 5/16/19.
//  Copyright © 2019 MDennis. All rights reserved.
//

import UIKit

extension UIColor {
  static var statusBarBlue: UIColor {
    return color(red: 46, green: 65, blue: 228)
  }
  
  static var navBarBlue: UIColor {
    return color(red: 63, green: 103, blue: 237)
  }
  
  ///
  /// Color helper
  ///
  static func color(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
  }
}
