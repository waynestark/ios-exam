//
//  MainViewModel.swift
//  Contacts
//
//  Created by Cielo Reyes on 9/5/22.
//

import Foundation

final class MainViewModel: MainViewModelProtocol {
  private var contactsService: ContactsServiceProtocol
  private var cacheService: CacheServiceProtocol
  private var persons: [Person] = []

  var mainSections: [SectionType] = []
  var favoriteCellVMs: [ContactCellViewModel] = []
  var contactCellVMs: [ContactCellViewModel] = []
  var isLoading: Bool = false

  init(
    contactsService: ContactsServiceProtocol = ContactsService(),
    cacheService: CacheServiceProtocol = CacheService()
  ) {
    self.contactsService = contactsService
    self.cacheService = cacheService
  }
}

// MARK: - Methods

extension MainViewModel {
  func fetchContacts(
    fromServer: Bool,
    onSuccess: @escaping VoidResult,
    onError: @escaping ErrorResult
  ) {
    let fromCache = cacheService.getCacheContactList()

    guard fromServer || fromCache.isEmpty else {
      processPersonList(fromCache)
      onSuccess()
      return
    }

    isLoading = true
    contactsService.getContacts(
      onSuccess: handleFetchContactSuccess(thenExecute: onSuccess),
      onError: handleError(thenExecute: onError)
    )
  }

  func markFavorite(
    for contact: ContactCellViewModel,
    completion: @escaping VoidResult
  ) {
    let person = contact.personObject

    if person.isFavorite {
      favoriteCellVMs.insert(contact, at: 0)
      if let index = contactCellVMs.firstIndex(of: contact) {
        contactCellVMs.remove(at: index)
      }
    } else {
      contactCellVMs.insert(contact, at: 0)
      if let index = favoriteCellVMs.firstIndex(of: contact) {
        favoriteCellVMs.remove(at: index)
      }
    }

    let favoritePersons = favoriteCellVMs.map { $0.personObject }
    let contactPersons = contactCellVMs.map { $0.personObject }
    cacheService.saveContactList(favoritePersons + contactPersons)

    mainSections.removeAll()
    if !favoriteCellVMs.isEmpty {
      mainSections.append(.favorite)
    }
    if !contactCellVMs.isEmpty {
      mainSections.append(.contact)
    }
    completion()
  }

  func personObject(for indexPath: IndexPath) -> Person {
    let section = mainSections[indexPath.section]
    let vm = section == .favorite ? favoriteCellVMs[indexPath.row] : contactCellVMs[indexPath.row]

    return vm.personObject
  }
}

// MARK: - Handlers

private extension MainViewModel {
  func handleError(
    thenExecute handler: @escaping (ErrorResult)
  ) -> ErrorResult {
    return { [weak self] error in
      guard let self = self else { return }

      self.isLoading = false
      handler(error)
    }
  }

  func handleFetchContactSuccess(
    thenExecute handler: @escaping VoidResult
  ) -> APIResult {
    return { [weak self] persons in
      guard let self = self else { return }

      self.processPersonList(persons)

      self.isLoading = false

      handler()
    }
  }

  func processPersonList(_ persons: [Person]) {
    guard !persons.isEmpty else { return }
    self.persons = persons
    let favorites = persons.filter { $0.isFavorite }
    let contacts = persons.filter { !$0.isFavorite }

    cacheService.saveContactList(favorites + contacts)

    mainSections.removeAll()
    if !favorites.isEmpty {
      favoriteCellVMs = favorites.map { ContactCellViewModel(person: $0) }
      mainSections.append(.favorite)
    }
    if !contacts.isEmpty {
      contactCellVMs = contacts.map { ContactCellViewModel(person: $0) }
      mainSections.append(.contact)
    }
  }
}
