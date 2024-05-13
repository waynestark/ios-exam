//
//  API.swift
//  UsersList
//
//  Created by Marc Jardine Esperas on 11/17/22.
//

import Foundation

public enum API {
    static func getUrl(with path: String = "") -> String {
        return "https://randomuser.me\(path)"
    }
}
