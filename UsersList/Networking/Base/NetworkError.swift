//
//  NetworkError.swift
//  UsersList
//
//  Created by Marc Jardine Esperas on 11/17/22.
//

import Foundation

public enum NetworkError: Error {
    case invalidUrl
    case unableToCompleteRequest
    case invalidResponse
    case invalidData
    case jsonDecodingError
    
    // Can be use in alert title
    var title: String {
        switch self {
            default:
                return ""
        }
    }
    
    var description: String {
        switch self {
            case .invalidUrl:
                return "Invalid URL"
            case .unableToCompleteRequest:
                return "Unable to complete your request, please check your internet connection."
            case .invalidResponse:
                return "Invalid response from the server, please try again."
            case .invalidData:
                return "Unable to complete your request, please check your internet connection."
            default:
                return self.localizedDescription
        }
    }
}
