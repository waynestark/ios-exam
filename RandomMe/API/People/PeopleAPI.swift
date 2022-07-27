//
//  PeopleAPI.swift
//  RandomMe
//
//  Created by Marwin Carino on 7/26/22.
//

import Alamofire
import Foundation

protocol PeopleAPI {
  @discardableResult
  func getRandomPeople(
    parameters: Parameters?,
    onSuccess: @escaping ([People]) -> Void,
    onError: @escaping ErrorResult
  ) -> DataRequest

  func decode<T>(
    data: Data,
    from keyPath: String?,
    decoder: JSONDecoder?
  ) -> T? where T: Decodable
}
