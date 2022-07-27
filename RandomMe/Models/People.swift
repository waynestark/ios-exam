//
//  People.swift
//  RandomMe
//
//  Created by Marwin Carino on 7/26/22.
//

import Foundation

// MARK: - Welcome

struct People: Codable {
  let cell: String
  let phone: String
  let birthDate: BirthDate
  let picture: Picture
  let location: Location
  let email: String
  let gender: String
  let name: Name

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    name = try container.decode(Name.self, forKey: .name)
    birthDate = try container.decode(BirthDate.self, forKey: .birthDate)
    gender = try container.decode(String.self, forKey: .gender)

    cell = try container.decode(String.self, forKey: .cell)
    phone = try container.decode(String.self, forKey: .phone)
    email = try container.decode(String.self, forKey: .email)
    location = try container.decode(Location.self, forKey: .location)
    picture = try container.decode(Picture.self, forKey: .picture)
  }

  enum CodingKeys: String, CodingKey {
    case cell
    case phone
    case birthDate = "dob"
    case picture
    case location
    case email
    case gender
    case name
  }
}

// MARK: - BirthDate

struct BirthDate: Codable {
  let date: String
  let age: Int

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    date = try container.decode(String.self, forKey: .date)
    age = try container.decode(Int.self, forKey: .age)
  }

  enum CodingKeys: String, CodingKey {
    case date, age
  }
}

// MARK: - Location

struct Location: Codable {
  let street: Street
  let city: String
  let postcode: Int
  let country: String
  let state: String
  let coordinates: Coordinates

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    street = try container.decode(Street.self, forKey: .street)
    city = try container.decode(String.self, forKey: .city)
    state = try container.decode(String.self, forKey: .state)
    country = try container.decode(String.self, forKey: .country)
    coordinates = try container.decode(Coordinates.self, forKey: .coordinates)
      
      do {
          postcode = try container.decode(Int.self, forKey: .postcode)
      } catch {
          let _postcode = try container.decode(String.self, forKey: .postcode)
          postcode = Int(_postcode) ?? .zero
      }
  }

  enum CodingKeys: String, CodingKey {
    case street, city, state, postcode, country, coordinates
  }
}

// MARK: - Coordinates

struct Coordinates: Codable {
  let latitude: String
  let longitude: String

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    latitude = try container.decode(String.self, forKey: .latitude)
    longitude = try container.decode(String.self, forKey: .longitude)
  }

  enum CodingKeys: String, CodingKey {
    case latitude, longitude
  }
}

// MARK: - Street

struct Street: Codable {
  let number: Int
  let name: String

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    number = try container.decode(Int.self, forKey: .number)
    name = try container.decode(String.self, forKey: .name)
  }

  enum CodingKeys: String, CodingKey {
    case number, name
  }
}

// MARK: - Name

struct Name: Codable {
  let title: String
  let first: String
  let last: String

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    title = try container.decode(String.self, forKey: .title)
    first = try container.decode(String.self, forKey: .first)
    last = try container.decode(String.self, forKey: .last)
  }

  enum CodingKeys: String, CodingKey {
    case title, first, last
  }
}

// MARK: - Picture

struct Picture: Codable {
  let thumbnail: String?
  let medium: String?
  let large: String?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail) ?? .empty
    medium = try container.decodeIfPresent(String.self, forKey: .medium) ?? .empty
    large = try container.decodeIfPresent(String.self, forKey: .large) ?? .empty
  }

  enum CodingKeys: String, CodingKey {
    case thumbnail, medium, large
  }
}
