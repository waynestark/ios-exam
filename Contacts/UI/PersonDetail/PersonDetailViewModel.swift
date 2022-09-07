//
//  PersonDetailViewModel.swift
//  Contacts
//
//  Created by Cielo Reyes on 9/5/22.
//

import Foundation

final class PersonDetailViewModel: PersonDetailViewModelProtocol {
  private let person: Person

  init(person: Person) {
    self.person = person
  }
}

// MARK: - Getters

extension PersonDetailViewModel {
  var personId: String { person.id }
  var avatarURL: URL { person.avatar }
  var fullNameText: String { person.fullName }
  var firstNameText: String { person.firstName }
  var lastNameText: String { person.lastName }
  var birthdayText: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    return dateFormatter.string(from: person.birthday)
  }
  var ageText: String { String(person.age) }
  var emailText: String { person.email }
  var mobileNumberText: String { person.mobileNumber }
  var addressText: String { person.address }
  var isFavorite: Bool { person.isFavorite }
  var contactPersonNameText: String { person.contactPerson.name }
  var contactPersonNumberText: String { person.contactPerson.contactNumber }
  var type: SectionType { person.isFavorite ? .favorite : .contact }
}
