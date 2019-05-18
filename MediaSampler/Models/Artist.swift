//
//  Artist.swift
//  MediaSampler
//
//  Created by Marquis Dennis on 5/17/19.
//  Copyright © 2019 MDennis. All rights reserved.
//

import Foundation

///
/// Artist data structure returned as a part of Movie Detail
///
class Artist: Codable {
  var id: Int64?
  var name: String?
  var favorite: Bool?
  var artKey: String?
  var relationship: String?
  
  var artistType: ArtistType {
    return ArtistType(rawValue: relationship ?? "") ?? .other
  }
  // Conform to Codable protocol for serialization and deserialization of JSON objects.
  enum ArtistKeys: String, CodingKey {
    case id = "id"
    case name = "name"
    case favorite = "title"
    case artKey = "artKey"
    case relationship = "relationship"
  }
  
  // MARK: - Initializers
  
  ///
  /// Initializes an instance of artist using Decoder.
  /// Parameters:
  ///   - `decoder`: Data object to be deserialized to form a movie object.
  ///
  required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: ArtistKeys.self)
    id = try values.decodeIfPresent(Int64.self, forKey: .id)
    name = try values.decodeIfPresent(String.self, forKey: .name)
    artKey = try values.decodeIfPresent(String.self, forKey: .artKey)
    favorite = try values.decodeIfPresent(Bool.self, forKey: .favorite)
    relationship = try values.decodeIfPresent(String.self, forKey: .relationship)
  }
}

enum ArtistType: String {
  case director = "DIRECTOR"
  case actor = "ACTOR"
  case producer = "PRODUCER"
  case writer = "WRITER"
  case other = "OTHER"
}

