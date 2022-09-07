//
//  ContactResults.swift
//  Contacts
//
//  Created by Cielo Reyes on 9/6/22.
//

import Foundation

struct ContactResults: Decodable {
  let results: [Person]
  let info: Info
}

struct Info: Decodable {
  let results: String?
  let page: String?
}
