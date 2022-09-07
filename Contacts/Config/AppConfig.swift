//
//  AppConfig.swift
//  Contacts
//
//  Created by Cielo Reyes on 9/6/22.
//

import Foundation

protocol AppConfigProtocol {
  var apiURL: URL { get }
}

struct AppConfig: AppConfigProtocol {
  private var baseUrl: String { "https://randomapi.com/api" }
  private var publicAPIId: String { "a09d9cb4e7c33d42ecd182f2335351fa" }
  private var resultCount: Int { 10 }

  static let shared = AppConfig()
}

extension AppConfig {
  var apiURL: URL { URL(string: "\(baseUrl)/\(publicAPIId)?results=\(resultCount)")! }
}
