//
//  PersonDetailViewModelProtocol.swift
//  Contacts
//
//  Created by Cielo Reyes on 9/5/22.
//

import Foundation

protocol PersonDetailViewModelProtocol {
  var personId: String { get }
  var avatarURL: URL { get }
  var fullNameText: String { get }
  var firstNameText: String { get }
  var lastNameText: String { get }
  var birthdayText: String { get }
  var ageText: String { get }
  var emailText: String { get }
  var mobileNumberText: String { get }
  var addressText: String { get }
  var isFavorite: Bool { get }
  var contactPersonNameText: String { get }
  var contactPersonNumberText: String { get }
}
