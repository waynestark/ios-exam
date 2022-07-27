//
//  PeopleService.swift
//  RandomMe
//
//  Created by Marwin Carino on 7/26/22.
//

import Alamofire
import Foundation

class PeopleService: PeopleServiceProtocol {
  private var people: [String]?

  private let api: PeopleAPI

  init(
    api: PeopleAPI
  ) {
    self.api = api
  }
}

extension PeopleService {
  func loadPeople(
    gender: Gender = .male,
    page: Int? = nil,
    onSuccess: @escaping ([People]) -> Void,
    onError: @escaping ErrorResult
  ) {
    var parameters: Parameters = [:]

    if let page = page {
      parameters["page"] = page
    }

    parameters["gender"] = gender.rawValue

    api.getRandomPeople(
      parameters: parameters,
      onSuccess: onSuccess,
      onError: onError
    )
  }
}
