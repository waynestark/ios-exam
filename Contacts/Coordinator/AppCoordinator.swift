//
//  AppCoordinator.swift
//  Contacts
//
//  Created by Cielo Reyes on 9/7/22.
//

import Hero
import UIKit

protocol Coordinator {
  func start()
}

final class AppCoordinator: Coordinator {
  private var navigationController: UINavigationController!
  private var mainVC: MainViewController!

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController

    mainVC = R.storyboard.main.mainViewController()!
    mainVC.viewModel = MainViewModel()
    mainVC.onDetails = loadDetails()
  }
}

extension AppCoordinator {
  func start() {
    navigationController.pushViewController(mainVC, animated: true)
  }
}

extension AppCoordinator {
  func loadDetails() -> DetailResult {
    return { [weak self] person in
      guard let self = self else { return }

      let vc = R.storyboard.main.personDetailController()!
      vc.viewModel = PersonDetailViewModel(person: person)
      vc.modalPresentationStyle = .fullScreen
      vc.hero.isEnabled = true
      vc.hero.modalAnimationType = .fade

      self.mainVC.present(vc, animated: true)
    }
  }
}
