//
//  APIError.swift
//  RandomUsers
//
//  Created by jmmanoza on 6/5/24.
//

import Foundation

enum APIError: LocalizedError {
    
    case invalidUrl
    case errorResponse
    case errorData
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid Url found."
        case .errorResponse:
            return "Error response."
        case .errorData:
            return "Error parse data."
        }
    }
}
