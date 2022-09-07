//
//  CacheServiceProtocol.swift
//  Contacts
//
//  Created by Cielo Reyes on 9/6/22.
//

import Foundation

protocol CacheServiceProtocol {
  func saveContactList(_ contacts: [Person])
  func getCacheContactList() -> [Person]
}
