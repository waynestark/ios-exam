//
//  UserRouter.swift
//  UsersList
//
//  Created by Marc Jardine Esperas on 11/17/22.
//

import Foundation

public extension API {
    enum UserRouter: AppNetworkable {
        case fetchUsers
        case fetchImageData(urlString: String)
        
        public var request: URLRequest {
            switch self {
                case .fetchUsers:
                    return getRequest(with: API.getUrl(with: "/api/?results=50"), httpMethod: .GET)
                case .fetchImageData(let urlString):
                    return getRequest(with: urlString, httpMethod: .GET)
            }
        }
    }
}
