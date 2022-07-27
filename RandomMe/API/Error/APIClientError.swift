//
//  APIClientError.swift
//  RandomMe
//
//  Created by Marwin Carino on 7/26/22.
//

import Foundation

enum APIClientError: Error {
  case failedRequest
  case dataNotFound
  case unknown
}

extension APIClientError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .failedRequest:
        return S.errorApiClientFailedRequest()
    case .dataNotFound:
        return S.errorApiClientDataNotFound()
    case .unknown:
        return S.errorApiClientUnknown()
    }
  }
}
