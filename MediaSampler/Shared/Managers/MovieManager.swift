//
//  MovieManager.swift
//  MediaSampler
//
//  Created by Marquis Dennis on 5/15/19.
//  Copyright © 2019 MDennis. All rights reserved.
//

import Foundation

class MovieManager {
  fileprivate var urlComponents: URLComponents?
  
  //kind for movies
  fileprivate let kindId = 7
  
  //let env -- can be set using scheme data or xcconfig
  var environment: Environment
  
  private init() {
    environment = Environment(platform: "production")
  }
  
  static let shared = MovieManager()
  
  ///
  /// Get a movie object by id.
  ///
  /// Parameters:
  ///   - id: Id of movie object to retrieve
  ///   - completion: Result enum for handling API Response
  ///
  func get(movieWithId id: Int64, completion: @escaping (Result<Movie?, MovieError>) -> Void) {
    urlComponents = environment.apiURLComponents
    urlComponents?.path = "/titles/\(id)"
  
    guard let url = urlComponents?.url else {
      completion(.failure(.badRequest))
      return
    }
    
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
  
    let request = Utils.request(for: url, usingHttpMethod: "GET", withHeaders: nil)
    let task = session.dataTask(with: request) { (data, response, error) in
      guard error == nil else {
        completion(.failure(.serverError))
        return
      }
      
      guard let data = data,
        let httpResponse = response as? HTTPURLResponse,
        (200..<300).contains(httpResponse.statusCode) else {
          completion(.failure(.serverError))
          return
      }
      
      let movie = Movie.getMovie(from: data)
      completion(.success(movie))
      return
    }
    
    task.resume()
  }
  
  ///
  /// Get Collection of Movie Objects
  ///   Parameters:
  ///     - completion: Result enum for handling API Response
  ///
  /// TODO: Add pagination parameters
  ///
  func getCollection(completion: @escaping (Result<[Movie], MovieError>) -> Void) {
    urlComponents = environment.apiURLComponents
    urlComponents?.path = "/kinds/7/titles/top"
    
    guard let url = urlComponents?.url else {
      completion(.failure(.badRequest))
      return
    }
    
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    let request = Utils.request(for: url, usingHttpMethod: "GET", withHeaders: nil)
    let task = session.dataTask(with: request) { (data, response, error) in
      guard error == nil else {
        completion(.failure(.serverError))
        return
      }
      
      guard let data = data,
        let httpResponse = response as? HTTPURLResponse,
        (200..<300).contains(httpResponse.statusCode) else {
          completion(.failure(.serverError))
          return
      }
      
      let movies = Movie.getMovies(from: data)
      completion(.success(movies ?? []))
      return
    }
    
    task.resume()
  }
}

/// Handle API Errors for Movie Kind
enum MovieError: Error {
  case badRequest
  case serverError
}

