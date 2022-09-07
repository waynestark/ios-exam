//
//  SectionType.swift
//  Contacts
//
//  Created by Cielo Reyes on 9/5/22.
//

import Foundation

enum SectionType {
  case favorite
  case contact

  var title: String {
    switch self {
    case .favorite: return R.string.localizable.favorites()
    case .contact: return R.string.localizable.contacts()
    }
  }
}

