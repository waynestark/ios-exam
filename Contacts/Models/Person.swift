//
//  Person.swift
//  Contacts
//
//  Created by Cielo Reyes on 9/6/22.
//

import Foundation

struct Person: Codable {
  let id: String
  var isFavorite: Bool

  let avatar: URL
  let firstName: String
  let lastName: String
  let birthday: Date
  let email: String
  let mobileNumber: String
  let address: String
  let contactPerson: ContactPerson
}

extension Person {
  var age: Int {
    let now = Date()
    let calendar = Calendar.current
    let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
    return ageComponents.year ?? 0
  }

  var fullName: String {
    "\(firstName) \(lastName)"
  }
}

extension Person: Equatable {
  static func == (lhs: Person, rhs: Person) -> Bool {
    return lhs.id == rhs.id
  }
}

struct ContactPerson: Codable {
  let name: String
  let contactNumber: String
}
