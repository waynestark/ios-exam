//
//  UserProfileViewModel.swift
//  UsersList
//
//  Created by Marc Jardine Esperas on 11/16/22.
//

import Foundation

protocol UserProfileViewModelProtocol {
    var user: User { get }
    func fetchImageData(with urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

class UserProfileViewModel: UserProfileViewModelProtocol {
    private let dataProvider: UserDataProviderProtocol
    var user: User
    
    init(dataProvider: UserDataProviderProtocol = UserDataProvider(),
         user: User) {
        self.dataProvider = dataProvider
        self.user = user
    }
    
    func fetchImageData(with urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        dataProvider.fetchImageData(urlString: urlString) { result in
            switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
