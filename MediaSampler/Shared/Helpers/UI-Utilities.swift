//
//  UI-Utilities.swift
//  MediaSampler
//
//  Created by Marquis Dennis on 5/15/19.
//  Copyright © 2019 MDennis. All rights reserved.
//

import UIKit

class UIUtils {
  private init() { }
  
  ///
  /// Displays a basic UIAlertController with "`OK`" action.
  ///
  /// Parameters:
  ///   - `title`: Title of alert
  ///   - `message`: Message of alert body
  ///
  static func displayBasicAlertAction(onViewController vc: UIViewController, withTitle title: String, message: String, completionHandler: ((UIAlertAction) -> Void)? = nil) {
    DispatchQueue.main.async {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let okAction = UIAlertAction(title: "OK", style: .default, handler: completionHandler)
      alert.addAction(okAction)
      vc.present(alert, animated: true, completion: nil)
    }
  }
}

extension UIViewController {
  ///
  /// Ends the refreshing on the control, on main thread, it its currently refreshing
  ///
  /// Parameters:
  ///   - `refreshControl`: Control that needs to end refreshing
  ///
  func endRefresh(onControl refreshControl: UIRefreshControl?) {
    DispatchQueue.main.async {
      if refreshControl?.isRefreshing ?? false {
        refreshControl?.endRefreshing()
      }
    }
  }
}
