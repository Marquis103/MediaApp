//
//  Genre.swift
//  MediaSampler
//
//  Created by Marquis Dennis on 5/18/19.
//  Copyright © 2019 MDennis. All rights reserved.
//

import Foundation

///
/// Genre data structure returned as a part of Movie Detail
///
class Genre: Codable {
  var id: Int64?
  var kindId: Int?
  var name: String?
  
  // Conform to Codable protocol for serialization and deserialization of JSON objects.
  enum GenreKeys: String, CodingKey {
    case id = "id"
    case kindId = "kindId"
    case name = "name"
  }
  
  // MARK: - Initializers
  
  ///
  /// Initializes an instance of genre using Decoder.
  /// Parameters:
  ///   - `decoder`: Data object to be deserialized to form a movie object.
  ///
  required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: GenreKeys.self)
    id = try values.decodeIfPresent(Int64.self, forKey: .id)
    kindId = try values.decodeIfPresent(Int.self, forKey: .kindId)
    name = try values.decodeIfPresent(String.self, forKey: .name)
    
  }
}
