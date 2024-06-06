//
//  FetchUsersUseCase.swift
//  RandomUsers
//
//  Created by jmmanoza on 6/5/24.
//

import Foundation

protocol FetchUsersUseCase {
    func execute(page: Int) async throws -> [Person]
}

class FetchUsersUseCaseImpl: FetchUsersUseCase {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute(page: Int) async throws -> [Person] {
        return try await userRepository.fetchUsers(page: page)
    }
}
