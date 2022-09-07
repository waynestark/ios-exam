//
//  MainViewModelProtocol.swift
//  Contacts
//
//  Created by Cielo Reyes on 9/5/22.
//

import Foundation

protocol MainViewModelProtocol {
  var mainSections: [SectionType] { get }
  var favoriteCellVMs: [ContactCellViewModel] { get }
  var contactCellVMs: [ContactCellViewModel] { get }
  var isLoading: Bool { get }

  func fetchContacts(
    fromServer: Bool,
    onSuccess: @escaping VoidResult,
    onError: @escaping ErrorResult
  )
  func markFavorite(
    for contact: ContactCellViewModel,
    completion: @escaping VoidResult
  )
  func personObject(for indexPath: IndexPath) -> Person
}
