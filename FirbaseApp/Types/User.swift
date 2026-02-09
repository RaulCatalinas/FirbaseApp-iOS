//
//  User.swift
//  FirbaseApp
//
//  Created by Tardes on 9/2/26.
//
import Foundation

struct UserEntity: Codable {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
    let photoURL: URL?
    let gender: Gender
    let birthday: Int64?
    let age: Int?
}
