//
//  CacheService.swift
//  Contacts
//
//  Created by Cielo Reyes on 9/6/22.
//

import Cache
import Foundation

final class CacheService: CacheServiceProtocol {
  private var storage: Storage<String, [Person]>!
  let storageKey = String(describing: Person.self)

  init() {
    let diskConfig = DiskConfig(name: storageKey)
    let memoryConfig = MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10)

    storage = try? Storage<String, [Person]>(
      diskConfig: diskConfig,
      memoryConfig: memoryConfig,
      transformer: TransformerFactory.forCodable(ofType: [Person].self)
    )
  }

  func saveContactList(_ contacts: [Person]) {
    guard let storage = storage else { return }

    try? storage.setObject(contacts, forKey: storageKey)
  }

  func getCacheContactList() -> [Person] {
    guard let storage = storage else { return [] }

    let contacts = try? storage.object(forKey: storageKey)

    return contacts ?? []
  }
}
