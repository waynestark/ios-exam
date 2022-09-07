//
//  ContactsServiceProtocol.swift
//  Contacts
//
//  Created by Cielo Reyes on 9/6/22.
//

import Foundation

protocol ContactsServiceProtocol {
  func getContacts(
    onSuccess: @escaping APIResult,
    onError: @escaping ErrorResult
  )
}
