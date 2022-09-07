//
//  ContactCellViewModelProtocol.swift
//  Contacts
//
//  Created by Cielo Reyes on 9/5/22.
//

import Foundation

protocol ContactCellViewModelProtocol {
  var personId: String { get }
  var avatarURL: URL { get }
  var fullNameText: String { get }
  var birthdayText: String { get }
  var emailText: String { get }
  var mobileNumberText: String { get }
  var isFavorite: Bool { get }
  var type: SectionType { get }
  var personObject: Person { get }

  var favoriteTapped: VoidResult? { get set }
  func markFavorite()
}
