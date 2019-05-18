//
//  LandscapeViewControllerPlayer.swift
//  MediaSampler
//
//  Created by Marquis Dennis on 5/18/19.
//  Copyright © 2019 MDennis. All rights reserved.
//

import UIKit
import AVKit

///
/// AVPlayerViewController that only supports landscape.
///
class LandscapeViewControllerPlayer: AVPlayerViewController {
  fileprivate let appDelegate = UIApplication.shared.delegate as? AppDelegate
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .landscape
  }
  
  override var shouldAutorotate: Bool {
    return false
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    UIView.animate(withDuration: 0.3) {
      self.appDelegate?.statusBarView?.isHidden = true
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    UIView.animate(withDuration: 0.3) {
      self.appDelegate?.statusBarView?.isHidden = false
    }
  }
}
