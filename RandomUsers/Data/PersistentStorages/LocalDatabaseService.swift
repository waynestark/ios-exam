//
//  LocalDatabaseService.swift
//  RandomUsers
//
//  Created by jmmanoza on 6/5/24.
//

import Foundation
import RealmSwift

class LocalDatabaseService {
    static let shared = LocalDatabaseService()
    private init() {}
    
    @MainActor
    func fetchLocalUsers(page: Int) async throws -> [Person] {

        let pageSize: Int = 10

        do {
            let realm = try Realm()
            let startIndex = (page - 1) * pageSize
            let user = realm.objects(Person.self)
                .dropFirst(startIndex)
                .prefix(pageSize)

            return  Array(user)

        } catch let error as NSError {
            print("Error fetchLocalUsers: \(error.localizedDescription)")
            return []
        }
    }
    
    @MainActor
    func saveUsers(_ users: [Person]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(users, update: .modified)
            }
        } catch let error as NSError {
            print("Error saveUsers: \(error.localizedDescription)")
        }
    }
    
    func deleteAllUsers() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch let error as NSError {
            print("Error saveUsers: \(error.localizedDescription)")
        }
    }
}
