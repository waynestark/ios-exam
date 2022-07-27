//
//  Optional+Collection.swift
//  RandomMe
//
//  Created by Marwin Carino on 7/26/22.
//

import Foundation

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        self?.isEmpty ?? true
    }
}
