//
//  UserDataProvider.swift
//  UsersList
//
//  Created by Marc Jardine Esperas on 11/17/22.
//

import Foundation

protocol UserDataProviderProtocol: AnyObject {
    func fetchUsers(completion: @escaping (Result<UserResponse, NetworkError>) -> Void)
    func fetchImageData(urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

public class UserDataProvider: UserDataProviderProtocol {
    public init() {}
    
    func fetchUsers(completion: @escaping (Result<UserResponse, NetworkError>) -> Void) {
        API.UserRouter.fetchUsers.fetchResponse(completion: completion)
    }
    
    func fetchImageData(urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        API.UserRouter.fetchImageData(urlString: urlString).fetchResponse(completion: completion)
    }
}
