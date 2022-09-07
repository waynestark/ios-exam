//
//  ContactsService.swift
//  Contacts
//
//  Created by Cielo Reyes on 9/6/22.
//

import Alamofire
import Foundation

final class ContactsService: ContactsServiceProtocol {
  private let apiURL: URL
  private let decoder: JSONDecoder

  init(apiURL: URL = AppConfig.shared.apiURL) {
    self.apiURL = apiURL

    // setup decoder
    decoder = JSONDecoder()

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-DD"
    decoder.dateDecodingStrategy = .formatted(dateFormatter)
  }
}

// MARK: - Methods

extension ContactsService {
  func getContacts(
    onSuccess: @escaping APIResult,
    onError: @escaping ErrorResult
  ) {
    AF.request(apiURL).responseDecodable(of: ContactResults.self, decoder: decoder) { response in
      switch response.result {
      case let .success(data):
        onSuccess(data.results)
      case let .failure(error):
        onError(error)
      }
    }
  }
}
