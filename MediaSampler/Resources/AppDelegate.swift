//
//  AppDelegate.swift
//  MediaSampler
//
//  Created by Marquis Dennis on 5/15/19.
//  Copyright © 2019 MDennis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    //not using storyboard
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.rootViewController = UINavigationController(rootViewController: rootController)
    
    setAppearance(forApplication: application)
    return true
  }

  func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    if let vc = window?.rootViewController?.presentedViewController, vc is LandscapeViewControllerPlayer {
      return vc.isBeingDismissed ? .portrait : .landscape
    }
    
    return .portrait
  }
}

extension AppDelegate {
  fileprivate func setAppearance(forApplication application: UIApplication) {
    UINavigationBar.appearance().barTintColor = .navBarBlue
    UINavigationBar.appearance().tintColor = .white
    UINavigationBar.appearance().isTranslucent = false
    
    //removes line for adjoining menubar
    UINavigationBar.appearance().shadowImage = UIImage()
    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    
    let attrs = [
      NSAttributedString.Key.foregroundColor: UIColor.white
    ]
    
    UINavigationBar.appearance().titleTextAttributes = attrs
    let statusBar = UIView()
    statusBar.backgroundColor = .statusBarBlue
    
    window?.addSubview(statusBar)
    window?.addConstraints(withFormat: "H:|[v0]|", forViews: statusBar)
    
    let height = application.statusBarFrame.height
    window?.addConstraints(withFormat: "V:[v0(\(height))]", forViews: statusBar)
  }
}

extension AppDelegate {
  fileprivate var rootController: UIViewController {
    let layout = UICollectionViewFlowLayout()
    return MovieListViewController(collectionViewLayout: layout)
  }
}
