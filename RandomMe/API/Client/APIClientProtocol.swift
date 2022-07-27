//
//  APIClientProtocol.swift
//  RandomMe
//
//  Created by Marwin Carino on 7/26/22.
//

import Foundation
import Alamofire

protocol APIClientProtocol {
    var baseURL: URL { get }
    
    func request(
        _ path: String,
        method: HTTPMethod,
        parameters: Parameters?,
        encoding: ParameterEncoding,
        headers: HTTPHeaders?,
        success: @escaping (Data) -> Void,
        failure: @escaping ErrorResult
    ) -> DataRequest
    
    func createEndpointURL(_ path: String) -> URL
    
    func cancelRequests(onComplete: VoidResult?)
}
