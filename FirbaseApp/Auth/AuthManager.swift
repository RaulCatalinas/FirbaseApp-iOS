//
//  AuthManager.swift
//  FirbaseApp
//
//  Created by Tardes on 5/2/26.
//

import FirebaseAuth

class AuthManager {
    private static let firbaseAuth = Auth.auth()

    static func singUp(
        email: String?,
        password: String?,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        guard let email, let password else {
            return
        }

        firbaseAuth.signIn(withEmail: email, password: password) {
            result,
            error in

            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                completion(.success(user))
            }
        }

    }

    static func signIn(
        email: String?,
        password: String?,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        guard let email, let password else {
            return
        }

        firbaseAuth.signIn(withEmail: email, password: password) {
            result,
            error in

            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                completion(.success(user))
            }
        }
    }

    static func singOut(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try firbaseAuth.signOut()
            completion(.success(Void()))
        } catch let error as NSError {
            print("Error signing out: \(error)")
            completion(.failure(error))
        }
    }
}
