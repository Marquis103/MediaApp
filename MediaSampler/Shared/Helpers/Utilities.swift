//
//  Utilities.swift
//  MediaSampler
//
//  Created by Marquis Dennis on 5/15/19.
//  Copyright © 2019 MDennis. All rights reserved.
//

import Foundation

typealias MovieDuration = (hours: Int, minutes: Int)

class Utils {
  ///
  /// Creates an URLRequset object for a given url, using a specfied http method,
  /// and with a collection of headers.
  ///
  /// Parameters:
  ///   - `url`: URL used to generate request
  ///   - `method`: Http method used for request. (defaults to "GET")
  ///   - `headers`: Addtional headers for request
  ///
  static func request(for url: URL, usingHttpMethod method: String, withHeaders headers: [String: String?]?) -> URLRequest {
    //create request
    var request = URLRequest(url: url)
    request.httpMethod = method
    
    //set required headers
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    headers?.forEach { key, val in
      request.setValue(val, forHTTPHeaderField: key)
    }
    
    return request
  }
}

extension Int {
  ///
  /// Converts seconds to hours and minutes
  ///
  var movieDuration: MovieDuration {
    let hours = self / 3600
    let minutes = (self % 3600) / 60
    return MovieDuration(hours, minutes)
  }
}
