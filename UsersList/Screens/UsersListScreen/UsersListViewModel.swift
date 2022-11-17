//
//  UsersListViewModel.swift
//  UsersList
//
//  Created by Marc Jardine Esperas on 11/17/22.
//

import Foundation

protocol UsersListViewModelProtocol {
    func numberOfItems(in section: Int) -> Int
    func user(at index: Int) -> User
    func fetchUsers(completion: @escaping (Result<Void, NetworkError>) -> Void)
    func fetchImageData(with urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

class UsersListViewModel: UsersListViewModelProtocol {
    private let dataProvider: UserDataProviderProtocol
    @Published private var usersList: [User] = []
    
    init(dataProvider: UserDataProviderProtocol = UserDataProvider()) {
        self.dataProvider = dataProvider
    }
    
    func numberOfItems(in section: Int) -> Int {
        return usersList.count
    }
    
    func user(at index: Int) -> User {
        return usersList[index]
    }
    
    func fetchUsers(completion: @escaping (Result<Void, NetworkError>) -> Void) {
        dataProvider.fetchUsers { [weak self] result in
            switch result {
                case .success(let response):
                    self?.usersList = response.usersList
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
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
