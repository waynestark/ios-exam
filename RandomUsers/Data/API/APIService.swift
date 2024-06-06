//
//  APIService.swift
//  RandomUsers
//
//  Created by jmmanoza on 6/5/24.
//

import Foundation

final class APIService {
    
    let baseURL = "https://randomuser.me/api/"
    static let shared = APIService()
    
    func fetchUsers(page: Int) async throws -> [Person] {
        let endpoint = baseURL + "?page=\(page)&results=10"
        
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidUrl
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.errorResponse
        }
        
        do {
            let response = try JSONDecoder().decode(RandomUserResponse.self, from: data)
            return response.results
        } catch {
            throw APIError.errorData
        }
    }
}
