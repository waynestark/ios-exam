//
//  APICaller.swift
//  Cybilltek
//
//  Created by Jervy Umandap on 5/8/24.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let myURL = URL(string: "https://randomuser.me/api/?page=1&results=10&seed=abc")
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    private init() {}
    
    public func getUsers(completion: @escaping(Result<[User], Error>) -> Void) {
        guard let url = Constants.myURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToGetData))
                return
            }
            
            do {
                //let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let result = try JSONDecoder().decode(RandomUserResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                print("getUsers: \(error.localizedDescription)")
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
}
