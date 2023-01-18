//
//  SceneDelegate.swift
//  UsersList
//
//  Created by Marc Jardine Esperas on 11/16/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
  
        let viewModel: UsersListViewModelProtocol = UsersListViewModel()
        let rootViewController = UsersListViewController.init(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        
        window = UIWindow(frame:  windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

