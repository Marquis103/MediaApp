//
//  Movie
//  MediaSampler
//
//  Created by Marquis Dennis on 5/15/19.
//  Copyright © 2019 MDennis. All rights reserved.
//

import Foundation

class Movie: Codable {
  var id: Int64?
  var title: String?
  var genre: [Genre]?
  var synopsis: String?
  var artistName: String?
  var year: Int?
  var artKey: String?
  var mediaKey: String?
  var rating: String?
  var lendingMessage: String?
  var artists: [Artist]?
  var content: [MovieContent]?
  
  var image: URL? {
    guard let key = artKey else { return nil }
    
    var components = Environment(platform: "production").cloudFrontComponents
    components?.path = "/\(key)_270.jpeg"
    
    if let url = components?.url {
      return url
    }
    
    return nil
  }

  ///
  /// Initializes an instance of movie using Decoder.
  /// Parameters:
  ///   - `decoder`: Data object to be deserialized to form a movie object.
  ///
  required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: MovieKeys.self)
    if let identifer = try values.decodeIfPresent(Int64.self, forKey: .id) {
      id = identifer
    } else if let identifier = try values.decodeIfPresent(Int64.self, forKey: .titleId) {
      id = identifier
    } else {
      let context = DecodingError.Context.init(codingPath: [MovieKeys.id, .titleId], debugDescription: "Keys not found!")
      throw DecodingError.keyNotFound(MovieKeys.id, context)
    }
    
    title = try values.decode(String.self, forKey: .title)
    artKey = try values.decode(String.self, forKey: .artKey)
    genre = try values.decodeIfPresent([Genre].self, forKey: .genre)
    synopsis = try values.decodeIfPresent(String.self, forKey: .synopsis)
    artistName = try values.decodeIfPresent(String.self, forKey: .artistNames)
    year = try values.decodeIfPresent(Int.self, forKey: .year)
    rating = try values.decodeIfPresent(String.self, forKey: .rating)
    lendingMessage = try values.decodeIfPresent(String.self, forKey: .lendingMessage)
    artists = try values.decodeIfPresent([Artist].self, forKey: .artists)
    content = try values.decodeIfPresent([MovieContent].self, forKey: .contents)
  }
}

extension Movie {
  // Conform to Codable protocol for serialization and deserialization of JSON objects.
  enum MovieKeys: String, CodingKey {
    case id = "id"
    case titleId = "titleId"
    case title = "title"
    case artKey = "artKey"
    case genre = "genres"
    case synopsis = "synopsis"
    case artistNames = "artistName"
    case year = "year"
    case contents = "contents"
    case mediaKey = "mediaKey"
    case rating = "rating"
    case lendingMessage = "lendingMessage"
    case artists = "artists"
  }
  
  /// Serializes a movie objects from data
  static func getMovies(from data: Data) -> [Movie]? {
    let jsonDecoder = JSONDecoder()
    do {
      let movie = try jsonDecoder.decode([Movie].self, from: data)
      return movie
    } catch let exception {
      print("Oh no! Unable to deserialize movie object: \(exception as Any)")
      return nil
    }
  }
  
  /// Serializes a movie objects from data
  static func getMovie(from data: Data) -> Movie? {
    let jsonDecoder = JSONDecoder()
    do {
      let movie = try jsonDecoder.decode(Movie.self, from: data)
      return movie
    } catch let exception {
      print("Oh no! Unable to deserialize movie object: \(exception as Any)")
      return nil
    }
  }
}

extension Movie {
  struct MovieContent: Codable {
    var duration: Int?
    
    enum MovieContentKeys: String, CodingKey {
      case duration = "seconds"
    }
    
    init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: MovieContentKeys.self)
      duration = try values.decodeIfPresent(Int.self, forKey: .duration)
    }
  }
}

