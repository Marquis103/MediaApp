//
//  UI-Utilities.swift
//  MediaSampler
//
//  Created by Marquis Dennis on 5/15/19.
//  Copyright © 2019 MDennis. All rights reserved.
//

import UIKit

class UIUtils {
  ///
  /// Displays a basic UIAlertController with "`OK`" action.
  ///
  /// Parameters:
  ///   - title: Title of alert
  ///   - message: Message of alert body
  ///
  static func displayBasicAlertAction(onViewController vc: UIViewController, withTitle title: String, message: String) {
    DispatchQueue.main.async {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alert.addAction(okAction)
      vc.present(alert, animated: true, completion: nil)
    }
  }
}
