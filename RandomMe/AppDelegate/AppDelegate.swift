//
//  AppDelegate.swift
//  RandomMe
//
//  Created by Marwin Carino on 7/26/22.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  // MARK: - Properties

  static var shared: AppDelegate {
    UIApplication.shared.delegate as! AppDelegate
  }

  var window: UIWindow?

  // MARK: - Life Cycle

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    App.shared.bootstrap(
      with: application,
      launchOptions: launchOptions
    )

    window?.makeKeyAndVisible()

    return true
  }
}
