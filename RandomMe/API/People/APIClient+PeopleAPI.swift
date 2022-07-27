//
//  APIClient+PeopleAPI.swift
//  RandomMe
//
//  Created by Marwin Carino on 7/26/22.
//

import Alamofire
import Foundation
import SwiftyJSON

extension APIClient: PeopleAPI {
  func getRandomPeople(
    parameters: Parameters? = nil,
    onSuccess: @escaping ([People]) -> Void,
    onError: @escaping ErrorResult
  ) -> DataRequest {
    var fixedParameters: Parameters = [
        "page": 1,
        "results": 20,
    ]
      
    if let additionalParameters = parameters {
      fixedParameters.merge(
        additionalParameters,
        uniquingKeysWith: { $1 }
      )
    }

    return request(
      "api/",
      method: .get,
      parameters: fixedParameters,
      success: { data in
        if let people: [People] = self.decode(
            data: data,
            from: "results"
        ) {
          onSuccess(people)
        } else {
          onError(ModelError.dataDecodingFailed)
        }
      },
      failure: onError
    )
  }

  func decode<T>(
    data: Data,
    from keyPath: String? = nil,
    decoder: JSONDecoder? = nil
  ) -> T? where T: Decodable {
    do {
      var json = try JSON(data: data)

      if let keyPath = keyPath {
        json = json[keyPath]
      }

      let decodedData = try JSONDecoder().decode(
        T.self,
        from: json.rawData()
      )

      return decodedData
    } catch {
      debugPrint(error.localizedDescription)

      return nil
    }
  }
}
