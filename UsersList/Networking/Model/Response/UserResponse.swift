//
//  UserResponse.swift
//  UsersList
//
//  Created by Marc Jardine Esperas on 11/17/22.
//

import Foundation

// MARK: - UserResponse
struct UserResponse: Codable {
    let usersList: [User]
    
    enum CodingKeys: String, CodingKey {
        case usersList = "results"
    }
}

// MARK: - Info
struct Info: Codable {
    let seed: String
    let results, page: Int
    let version: String
}

// MARK: - Result
struct User: Codable {
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob, registered: Dob
    let cell: String
    let picture: Picture
}

// MARK: - Dob
struct Dob: Codable {
    let date: String
    let age: Int
}

// MARK: - Location
struct Location: Codable {
    let street: Street
    let city, state, country: String
    let postcode: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        street = try container.decode(Street.self, forKey: .street)
        city = try container.decode(String.self, forKey: .city)
        state = try container.decode(String.self, forKey: .state)
        country = try container.decode(String.self, forKey: .country)
        
        if let intPostcode = try? container.decode(Int.self, forKey: .postcode) {
            postcode = String(intPostcode)
        } else if let stringPostcode = try? container.decode(String.self, forKey: .postcode) {
            postcode = stringPostcode
        } else {
            postcode = nil
        }
    }
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: String
}

// MARK: - Street
struct Street: Codable {
    let number: String?
    let name: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        if let intNumber = try? container.decode(Int.self, forKey: .number) {
            number = String(intNumber)
        } else if let stringNumber = try? container.decode(String.self, forKey: .number) {
            number = stringNumber
        } else {
            number = nil
        }
    }
}

// MARK: - Timezone
struct Timezone: Codable {
    let offset, timezoneDescription: String

    enum CodingKeys: String, CodingKey {
        case offset
        case timezoneDescription = "description"
    }
}

// MARK: - Login
struct Login: Codable {
    let username: String
}

// MARK: - Name
struct Name: Codable {
    let title, first, last: String
}

// MARK: - Picture
struct Picture: Codable {
    let large, medium, thumbnail: String
}
