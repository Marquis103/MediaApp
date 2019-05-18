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
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .landscape
  }
  
  override var shouldAutorotate: Bool {
    return false
  }
}
