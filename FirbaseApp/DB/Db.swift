//
//  Db.swift
//  FirbaseApp
//
//  Created by Tardes on 9/2/26.
//

import FirebaseFirestore

final class Db {
    static let shared = Db()

    private init() {}

    func saveUser(_ user: UserEntity) {
        do {
            let db = Firestore.firestore()

            try db.collection("Users").document(user.id).setData(from: user)
        } catch {
            print("Error saving user: \(error)")
        }
    }

    func existUser(withId id: String) async -> Bool {
        do {
            let db = Firestore.firestore()

            let docRef = db.collection("Users").document(id)

            try await docRef.getDocument()

            return true
        } catch {
            print("Error getting document: \(error)")

            return false
        }
    }
}
