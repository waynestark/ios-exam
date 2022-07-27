//
//  AppDelegate+RootViewController.swift
//  RandomMe
//
//  Created by Marwin Carino on 7/26/22.
//

import Foundation

extension AppDelegate {
  func updateRootViewController() {
    setRootToPeople()
  }
}

private extension AppDelegate {
  func setRootToPeople() {
    let navigationController = R.storyboard.people.instantiateInitialViewController()!

    if let peopleController = navigationController.viewControllers.first as? PeopleController {
      peopleController.viewModel = PeopleViewModel(gender: .male)
    } else {
      preconditionFailure("Expected PeopleController to be the first controller")
    }

    window?.rootViewController = navigationController
  }
}
