//
//  UserListViewModel.swift
//  RandomUsers
//
//  Created by jmmanoza on 6/5/24.
//

import Foundation

class UserListViewModel: ObservableObject {
    @Published var users: [Person] = []
    @Published var isLoading: Bool = false
    @Published var errorMsg: String = ""
    private let dbService = LocalDatabaseService.shared
    private let fetchUsersUseCase: FetchUsersUseCase
    private var currentPage = 1
    
    init(fetchUsersUseCase: FetchUsersUseCase) {
        self.fetchUsersUseCase = fetchUsersUseCase
    }
    
    @MainActor
    func fetchUsers() async {
        isLoading = true
        do {
            let newUsers = try await fetchUsersUseCase.execute(page: currentPage)
            users.append(contentsOf: newUsers)
            currentPage += 1
        } catch let error {
            self.errorMsg = error.localizedDescription
        }
        
        isLoading = false
    }
    
    @MainActor
    func refreshUsers() async {
        currentPage = 1
        users.removeAll()
        await fetchUsers()
    }
    
    func removeDB() {
        dbService.deleteAllUsers()
    }
}
