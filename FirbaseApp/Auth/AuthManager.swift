//
//  AuthManager.swift
//  FirbaseApp
//
//  Created by Tardes on 5/2/26.
//

import FirebaseAuth

private enum AuthError: LocalizedError {
    case invalidPassword
    case unknown
    case signOutFailed(underlying: Error)

    var errorDescription: String? {
        switch self {
        case .invalidPassword:
            return "The password can't be less than 6 characters or empty"
        case .unknown:
            return "Unknown error"
        case .signOutFailed:
            return "Failed to sign out"
        }
    }
}

enum AuthProvider {
    case google
    case facebook
    case twitter
    case apple
}

class AuthManager {
    private static let firebaseAuth = Auth.auth()

    static func signUp(
        email: String?,
        password: String?,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        guard let email, let password else {
            return
        }

        if !validatePassword(password: password) {
            completion(.failure(AuthError.invalidPassword))
            return
        }

        firebaseAuth.createUser(withEmail: email, password: password) {
            result,
            error in

            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                completion(.success(user))
            } else {
                completion(.failure(AuthError.unknown))
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

        if !validatePassword(password: password) {
            completion(.failure(AuthError.invalidPassword))
            return
        }

        firebaseAuth.signIn(withEmail: email, password: password) {
            result,
            error in

            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                completion(.success(user))
            } else {
                completion(.failure(AuthError.unknown))
            }
        }
    }

    static func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try firebaseAuth.signOut()
            completion(.success(Void()))
        } catch {
            let error = error
            print("Error signing out: \(error)")
            completion(.failure(AuthError.signOutFailed(underlying: error)))
        }
    }

    static func signIn(
        with provider: AuthProvider,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        switch provider {
        case .google:
            do {
                print("Singing in with Google...")
            }
        case .twitter:
            do {
                print("Singing in with Twitter...")
            }
        case .apple:
            do {
                print("Singing in with Apple...")
            }
        case .facebook:
            do {
                print("Singing in with Facebook...")
            }
        }
    }

    private static func validatePassword(password: String) -> Bool {
        return !password.isEmpty && password.count >= 6
    }
}
