//
//  AuthValidations.swift
//  FirbaseApp
//
//  Created by Tardes on 6/2/26.
//

import Foundation

enum AuthValidationError: LocalizedError {
    case missingFields
    case invalidEmail
    case invalidPassword
    case passwordsDoNotMatch
    case invalidName
    case underAge

    var errorDescription: String? {
        switch self {
        case .missingFields:
            return "All fields are required"
        case .invalidEmail:
            return "Invalid email format"
        case .invalidPassword:
            return "Password must be at least 6 characters"
        case .passwordsDoNotMatch:
            return "Passwords do not match"
        case .invalidName:
            return "Name cannot be empty"
        case .underAge:
            return "You must be at least 13 years old"
        }
    }
}

final class AuthValidator {
    static func validateSignUp(
        firstName: String?,
        lastName: String?,
        email: String?,
        password: String?,
        repeatPassword: String?,
        birthday: Date
    ) -> Result<Void, Error> {

        guard
            let firstName,
            let lastName,
            let email,
            let password,
            let repeatPassword
        else {
            return .failure(AuthValidationError.missingFields)
        }

        if !validateName(firstName) || !validateName(lastName) {
            return .failure(AuthValidationError.invalidName)
        }

        if !validateEmail(email) {
            return .failure(AuthValidationError.invalidEmail)
        }

        if !validatePassword(password) {
            return .failure(AuthValidationError.invalidPassword)
        }

        if password != repeatPassword {
            return .failure(AuthValidationError.passwordsDoNotMatch)
        }

        if !isAdult(birthday: birthday) {
            return .failure(AuthValidationError.underAge)
        }

        return .success(())
    }

    static func validateSignIn(
        email: String?,
        password: String?
    ) -> Result<Void, Error> {

        guard let email, let password else {
            return .failure(AuthValidationError.missingFields)
        }

        if !validateEmail(email) {
            return .failure(AuthValidationError.invalidEmail)
        }

        if !validatePassword(password) {
            return .failure(AuthValidationError.invalidPassword)
        }

        return .success(())
    }

    // MARK: - Private helpers

    private static func validateEmail(_ email: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", EMAIL_REGEX)
            .evaluate(with: email)
    }

    private static func validatePassword(_ password: String) -> Bool {
        !password.isEmpty && password.count >= 6
    }

    private static func validateName(_ name: String) -> Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty
    }

    private static func isAdult(birthday: Date) -> Bool {
        let calendar = Calendar.current
        let age =
            calendar
            .dateComponents([.year], from: birthday, to: Date())
            .year ?? 0
        return age >= 13
    }
}
