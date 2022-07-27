//
//  PeopleServiceProtocol.swift
//  RandomMe
//
//  Created by Marwin Carino on 7/26/22.
//

import Foundation

protocol PeopleServiceProtocol {
    func loadPeople(
      gender: Gender,
      page: Int?,
      onSuccess: @escaping ([People]) -> Void,
      onError: @escaping ErrorResult
    )
}
