//
//  AuthManager.swift
//  FirbaseApp
//
//  Created by Tardes on 5/2/26.
//

import FirebaseAuth

private enum AuthError: LocalizedError {
    case unknown
    case signOutFailed(underlying: Error)

    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .signOutFailed:
            return "Failed to sign out"
        }
    }
}

final class AuthManager {
    private static let firebaseAuth = Auth.auth()

    static func signUp(
        firtsName: String?,
        lastName: String?,
        email: String?,
        password: String?,
        repeatPassword: String?,
        birthday: Date,
        gender: Gender,
        completion: @escaping (Result<User, Error>) -> Void
    ) {

        let validationResult = AuthValidator.validateSignUp(
            firstName: firtsName,
            lastName: lastName,
            email: email,
            password: password,
            repeatPassword: repeatPassword,
            birthday: birthday
        )

        guard case .success = validationResult else {
            if case .failure(let error) = validationResult {
                completion(.failure(error))
            }

            return
        }

        firebaseAuth.createUser(withEmail: email!, password: password!) {
            result,
            error in

            if let error {
                completion(.failure(error))
                return
            }

            guard let user = result?.user else {
                completion(.failure(AuthError.unknown))
                return
            }

            completion(.success(user))
        }
    }

    static func signIn(
        email: String?,
        password: String?,
        completion: @escaping (Result<User, Error>) -> Void
    ) {

        let validationResult = AuthValidator.validateSignIn(
            email: email,
            password: password
        )

        guard case .success = validationResult else {
            if case .failure(let error) = validationResult {
                completion(.failure(error))
            }

            return
        }

        firebaseAuth.signIn(withEmail: email!, password: password!) {
            result,
            error in

            if let error {
                completion(.failure(error))
                return
            }

            guard let user = result?.user else {
                completion(.failure(AuthError.unknown))
                return
            }

            completion(.success(user))
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
            } catch let error as NSError {
                print("Error signing in with Google: \(error)")
                completion(.failure(error))
            }
        case .twitter:
            do {
                print("Singing in with Twitter...")
            } catch let error as NSError {
                print("Error signing in with Twitter: \(error)")
                completion(.failure(error))
            }
        case .apple:
            do {
                print("Singing in with Apple...")
            } catch let error as NSError {
                print("Error signing in with Apple: \(error)")
                completion(.failure(error))
            }
        case .facebook:
            do {
                print("Singing in with Facebook...")
            } catch let error as NSError {
                print("Error signing in with Facebook: \(error)")
                completion(.failure(error))
            }
        }
    }

    private static func validatePassword(password: String) -> Bool {
        return !password.isEmpty && password.count >= 6
    }

    private static func validateRepeatPassword(
        password: String,
        repeatPassword: String
    ) -> Bool {
        return password == repeatPassword
    }
}
