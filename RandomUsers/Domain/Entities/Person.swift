//
//  User.swift
//  RandomUsers
//
//  Created by jmmanoza on 6/5/24.
//

import Foundation
import RealmSwift

// MARK: - RandomUserResponse
class RandomUserResponse: Object, Codable {
    var results : [Person] = [Person]()
    @objc dynamic var info: Info?

    private enum CodingKeys: String, CodingKey {
        case results, info
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results = try container.decodeIfPresent([Person].self, forKey: .results) ?? []
        info = try container.decode(Info.self, forKey: .info)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Array(results), forKey: .results)
        try container.encode(info, forKey: .info)
    }
}

// MARK: - Info
class Info: Object, Codable {
    @objc dynamic var seed: String = ""
    @objc dynamic var results: Int = 0
    @objc dynamic var page: Int = 0
    @objc dynamic var version: String = ""

    private enum CodingKeys: String, CodingKey {
        case seed, results, page, version
    }
}

// MARK: - Person
class Person: Object, Codable {
    @objc dynamic var _id = UUID().uuidString
    
    @objc dynamic var gender: String = ""
    @objc dynamic var name: Name?
    @objc dynamic var location: Location?
    @objc dynamic var email: String = ""
    @objc dynamic var login: Login?
    @objc dynamic var dob: Dob?
    @objc dynamic var registered: Dob?
    @objc dynamic var phone: String = ""
    @objc dynamic var cell: String = ""
    @objc dynamic var id: ID?
    @objc dynamic var picture: Picture?
    @objc dynamic var nat: String = ""

    private enum CodingKeys: String, CodingKey {
        case gender, name, location, email, login, dob, registered, phone, cell, id, picture, nat
    }
    
    override static func primaryKey() -> String? {
         return "_id"
     }
}

// MARK: - Dob
class Dob: Object, Codable {
    @objc dynamic var date: String = ""
    @objc dynamic var age: Int = 0

    private enum CodingKeys: String, CodingKey {
        case date, age
    }
}

// MARK: - ID
class ID: Object, Codable {
    @objc dynamic var name: String = ""
    @objc dynamic var value: String?

    private enum CodingKeys: String, CodingKey {
        case name, value
    }
}

// MARK: - Location
class Location: Object, Codable {
    @objc dynamic var street: Street?
    @objc dynamic var city: String = ""
    @objc dynamic var state: String = ""
    @objc dynamic var country: String = ""
    @objc dynamic var postcode: Postcode?
    @objc dynamic var coordinates: Coordinates?
    @objc dynamic var timezone: Timezone?

    private enum CodingKeys: String, CodingKey {
        case street, city, state, country, postcode, coordinates, timezone
    }
}

// MARK: - Coordinates
class Coordinates: Object, Codable {
    @objc dynamic var latitude: String = ""
    @objc dynamic var longitude: String = ""

    private enum CodingKeys: String, CodingKey {
        case latitude, longitude
    }
}

// MARK: - Postcode
class Postcode: Object, Codable {
    @objc dynamic var value: String = ""

    private enum CodingKeys: String, CodingKey {
        case value
    }

    convenience init(integer: Int) {
        self.init()
        self.value = String(integer)
    }

    convenience init(string: String) {
        self.init()
        self.value = string
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self.value = String(x)
        } else if let x = try? container.decode(String.self) {
            self.value = x
        } else {
            throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Postcode"))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let intValue = Int(value) {
            try container.encode(intValue)
        } else {
            try container.encode(value)
        }
    }
}

// MARK: - Street
class Street: Object, Codable {
    @objc dynamic var number: Int = 0
    @objc dynamic var name: String = ""

    private enum CodingKeys: String, CodingKey {
        case number, name
    }
}

// MARK: - Timezone
class Timezone: Object, Codable {
    @objc dynamic var offset: String = ""
    @objc dynamic var descriptionField: String = ""

    private enum CodingKeys: String, CodingKey {
        case offset
        case descriptionField = "description"
    }
}

// MARK: - Login
class Login: Object, Codable {
    @objc dynamic var uuid: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var salt: String = ""
    @objc dynamic var md5: String = ""
    @objc dynamic var sha1: String = ""
    @objc dynamic var sha256: String = ""

    private enum CodingKeys: String, CodingKey {
        case uuid, username, password, salt, md5, sha1, sha256
    }
}

// MARK: - Name
class Name: Object, Codable {
    @objc dynamic var title: String = ""
    @objc dynamic var first: String = ""
    @objc dynamic var last: String = ""

    private enum CodingKeys: String, CodingKey {
        case title, first, last
    }
}

// MARK: - Picture
class Picture: Object, Codable {
    @objc dynamic var large: String = ""
    @objc dynamic var medium: String = ""
    @objc dynamic var thumbnail: String = ""

    private enum CodingKeys: String, CodingKey {
        case large, medium, thumbnail
    }
}
