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
  var genre: String?
  var synopsis: String?
  var artistNames: String?
  var language: String?
  var year: Int?
  var artKey: String?
  
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
    genre = try values.decodeIfPresent(String.self, forKey: .genre)
    synopsis = try values.decodeIfPresent(String.self, forKey: .synopsis)
    artistNames = try values.decodeIfPresent(String.self, forKey: .artistNames)
    language = try values.decodeIfPresent(String.self, forKey: .language)
    year = try values.decodeIfPresent(Int.self, forKey: .year)
    
  }
}

extension Movie {
  // Conform to Codable protocol for serialization and deserialization of JSON objects.
  enum MovieKeys: String, CodingKey {
    case id = "id"
    case titleId = "titleId"
    case title = "title"
    case artKey = "artKey"
    case genre = "genre"
    case synopsis = "synopsis"
    case artistNames = "artistName"
    case language = "language"
    case year = "year"
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
}
