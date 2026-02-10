//
//  Db.swift
//  FirbaseApp
//
//  Created by Tardes on 9/2/26.
//

import FirebaseFirestore

final class Db {
    static let shared = Db()
    private let db = Firestore.firestore()

    private init() {}

    func saveUser(_ user: UserEntity) {
        do {

            try db.collection("Users").document(user.id).setData(from: user)
        } catch {
            print("Error saving user: \(error)")
        }
    }

    func existUser(withId id: String) async -> Bool {
        do {
            let docRef = db.collection("Users").document(id)

            let doc = try await docRef.getDocument()

            return doc.exists
        } catch {
            print("Error getting document: \(error)")

            return false
        }
    }
}
