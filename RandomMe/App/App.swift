//
//  App.swift
//  RandomMe
//
//  Created by Marwin Carino on 7/26/22.
//

import Foundation
import UIKit

import AlamofireNetworkActivityLogger
import SVProgressHUD

final class App {
  static let shared = App()

  private(set) var randomUserAPI: APIClient!
  private(set) var peopleService: PeopleServiceProtocol!
}

// MARK: - Setup

extension App {
  func bootstrap(
    with application: UIApplication,
    launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) {
    setupAPI()
    setupPeopleService()
    setupNetworkLogger()
      
    SVProgressHUD.setDefaultMaskType(.black)
  }
}

private extension App {
  func setupAPI() {
    randomUserAPI = APIClient(baseURL: URL(string: "https://randomuser.me")!)
  }

  func setupPeopleService() {
    peopleService = PeopleService(api: randomUserAPI)
  }

  func setupNetworkLogger() {
    NetworkActivityLogger.shared.level = .debug
    NetworkActivityLogger.shared.startLogging()
  }
}
