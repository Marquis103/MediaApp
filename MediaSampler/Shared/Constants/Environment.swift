//
//  Environment.swift
//  MediaSampler
//
//  Created by Marquis Dennis on 5/15/19.
//  Copyright © 2019 MDennis. All rights reserved.
//

import Foundation

private struct EnvironmentConstants {
  private init (){}
  
  static var productionSecureScheme     = "https"
  static var productionUnsecureScheme   = "http"
  static var productionAPIHost          = "hoopla-ws.hoopladigital.com"
  static var productionWebsiteURLHost   = "hoopla.com"
  static var productionCloudHost        = "d2snwnmzyr8jue.cloudfront.net"

}

///
/// Environemnt builds URL paths for a given url in a particular environment.
///
enum Environment: String {
  case production
  case staging
  case development
  
  init(platform: String) {
    switch platform {
    case Environment.production.rawValue:
      self = .production
    case Environment.staging.rawValue:
      self = .staging
    case Environment.development.rawValue:
      self = .development
    default:
      self = .production
    }
  }

  /// API URL for different environemnts
  var apiURLComponents: URLComponents? {
    switch self {
    case .production:
      var urlComponents = URLComponents()
      urlComponents.scheme = EnvironmentConstants.productionSecureScheme
      urlComponents.host = EnvironmentConstants.productionAPIHost
      return urlComponents
    default: return nil
    }
  }
  
  /// Cloudfront URL for artkey data
  var cloudFrontComponents: URLComponents? {
    switch self {
    case .production:
      var urlComponents = URLComponents()
      urlComponents.scheme = EnvironmentConstants.productionUnsecureScheme
      urlComponents.host = EnvironmentConstants.productionCloudHost
      return urlComponents
    default: return nil
    }
  }
}
