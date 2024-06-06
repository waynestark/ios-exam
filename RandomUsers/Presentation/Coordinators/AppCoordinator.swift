//
//  AppCoordinator.swift
//  RandomUsers
//
//  Created by jmmanoza on 6/5/24.
//

import Foundation
import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let userRepository: UserRepository
    
    init(window: UIWindow) {
        self.window = window
        
        self.userRepository = UserRepositoryImpl(apiService: APIService.shared,
                                                 localDatabaseService: LocalDatabaseService.shared)
    }
    
    func start() {

        let fetchUsersUseCase = FetchUsersUseCaseImpl(userRepository: userRepository)
        let viewModel = UserListViewModel(fetchUsersUseCase: fetchUsersUseCase)
        let listViewController = ListViewController(viewModel: viewModel)
        
        listViewController.onPersonSelected = { [weak self] person in
            self?.showDetail(for: person)
        }

        window.rootViewController = UINavigationController(rootViewController: listViewController)
        window.makeKeyAndVisible()
    }
    
    func showDetail(for person: Person) {
        let detailViewController = DetailsViewController()
        detailViewController.person = person
        if let navigationController = window.rootViewController as? UINavigationController {
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
}
