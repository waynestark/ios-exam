//
//  ContactCellViewModel.swift
//  Contacts
//
//  Created by Cielo Reyes on 9/5/22.
//

import Foundation

final class ContactCellViewModel: ContactCellViewModelProtocol {
  private var person: Person
  var favoriteTapped: VoidResult?

  init(person: Person) {
    self.person = person
  }
}

// MARK: - Methods

extension ContactCellViewModel {
  func markFavorite() {
    person.isFavorite = !person.isFavorite
    favoriteTapped?()
  }
}

// MARK: - Getters

extension ContactCellViewModel {
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

  var emailText: String { person.email }
  var mobileNumberText: String { person.mobileNumber }
  var addressText: String { person.address }
  var isFavorite: Bool { person.isFavorite }
  var contactPersonNameText: String { person.contactPerson.name }
  var contactPersonNumberText: String { person.contactPerson.contactNumber }
  var type: SectionType { person.isFavorite ? .favorite : .contact }
  var personObject: Person { person }
}

extension ContactCellViewModel: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(person.id)
  }

  static func == (lhs: ContactCellViewModel, rhs: ContactCellViewModel) -> Bool {
    lhs.person.id == rhs.person.id
  }
}
