//
//  UserRepository.swift
//  RandomUsers
//
//  Created by jmmanoza on 6/5/24.
//

import Foundation

protocol UserRepository {
    func fetchUsers(page: Int) async throws -> [Person]
}

class UserRepositoryImpl: UserRepository {
    private let apiService: APIService
    private let localDatabaseService: LocalDatabaseService
    
    init(apiService: APIService, localDatabaseService: LocalDatabaseService) {
        self.apiService = apiService
        self.localDatabaseService = localDatabaseService
    }
    
    func fetchUsers(page: Int) async throws -> [Person] {
        
        do {
            let users = try await apiService.fetchUsers(page: page)
            await localDatabaseService.saveUsers(users)
            return users
        } catch {
            return try await localDatabaseService.fetchLocalUsers(page: page)
        }
    }
}
