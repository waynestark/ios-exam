//
//  ModelError.swift
//  RandomMe
//
//  Created by Marwin Carino on 7/26/22.
//

import Foundation


enum ModelError: Error {
  case dataDecodingFailed
  case unknown
}

extension ModelError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .dataDecodingFailed:
        return S.errorModelDataDecodingFailed()
    case .unknown:
        return S.errorModelUnknown()
    }
  }
}
