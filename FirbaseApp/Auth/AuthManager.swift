//
//  AuthManager.swift
//  FirbaseApp
//
//  Created by Tardes on 5/2/26.
//

import FirebaseAuth
import FirebaseCore
import GoogleSignIn

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

        if case .failure(let error) = validationResult {
            completion(.failure(error))
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

        if case .failure(let error) = validationResult {
            completion(.failure(error))
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
        viewController: UIViewController? = nil,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        switch provider {
        case .google:
            guard let viewController else { return }
            guard let clientID = FirebaseApp.app()?.options.clientID else {
                return
            }

            // Create Google Sign In configuration object.
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config

            // Start the sign in flow!
            GIDSignIn.sharedInstance.signIn(withPresenting: viewController) {
                result,
                error in
                if let error = error {
                    print("Error signing in with Google: \(error)")
                    completion(.failure(error))
                    return
                }

                guard let user = result?.user,
                    let idToken = user.idToken?.tokenString
                else { return }

                let credential = GoogleAuthProvider.credential(
                    withIDToken: idToken,
                    accessToken: user.accessToken.tokenString
                )

                firebaseAuth.signIn(with: credential) { result, error in
                    if let error {
                        completion(.failure(error))
                        return
                    }

                    guard let firebaseUser = result?.user else {
                        completion(.failure(AuthError.unknown))
                        return
                    }

                    completion(.success(firebaseUser))
                }
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

    static func isUserLoggedIn() -> Bool {
        return firebaseAuth.currentUser != nil
    }

    // MARK: Private helpers

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
