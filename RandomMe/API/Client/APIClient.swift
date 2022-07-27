//
//  APIClient.swift
//  RandomMe
//
//  Created by Marwin Carino on 7/26/22.
//

import Alamofire
import Foundation
import SwiftyJSON

class APIClient: APIClientProtocol {
  private(set) var session: Session
  private(set) var baseURL: URL

  private var isCancellingAllRequests: Bool = false

  init(
    session: Session = Alamofire.Session.default,
    baseURL: URL
  ) {
    self.session = session
    self.baseURL = baseURL

    reset()
  }
}

// MARK: - Methods

extension APIClient {
  func request(
    _ path: String,
    method: HTTPMethod,
    parameters: Parameters? = nil,
    encoding: ParameterEncoding = URLEncoding.default,
    headers: HTTPHeaders? = nil,
    success: @escaping (Data) -> Void,
    failure: @escaping ErrorResult
  ) -> DataRequest {
      session.request(
        createEndpointURL(path),
        method: method,
        parameters: parameters,
        encoding: encoding,
        headers: headers
      ).responseData { response in
          if let _ = response.error {
              return failure(APIClientError.failedRequest)
          }
          
          guard let value = response.value else {
              return failure(APIClientError.dataNotFound)
          }
          
          return success(value)
      }
  }

  func createEndpointURL(_ path: String) -> URL {
    return baseURL.appendingPathComponent(path)
  }

  func cancelRequests(onComplete: VoidResult? = nil) {
    guard !isCancellingAllRequests else { return }

    isCancellingAllRequests = true

    session.session.getAllTasks { tasks in
      tasks.forEach { task in
        task.cancel()
      }

      DispatchQueue.main.async {
        self.isCancellingAllRequests = false
        onComplete?()
      }
    }
  }
}

// MARK: - Methods

private extension APIClient {
  func reset() {
    cancelRequests()
  }
}
