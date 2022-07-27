//
//  String.swift
//  RandomMe
//
//  Created by Marwin Carino on 7/26/22.
//

import Foundation

extension String {
    static var empty: String { "" }
    
    var trimmed: String { trimmingCharacters(in: .whitespaces) }
}

extension String {
    func toURL() -> URL? {
        guard let url = URL(string: self) else {
            return nil
        }
        
        return url
    }
}
