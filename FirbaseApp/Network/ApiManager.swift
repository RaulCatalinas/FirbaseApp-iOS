//
//  ApiManager.swift
//  FirbaseApp
//
//  Created by Tardes on 9/2/26.
//

import Foundation

final class ApiManager {
    static func getAllrecipes() async -> [Recipe] {
        do {
            let (res, _) = try await URLSession.shared.data(
                from: URL(string: "\(BASE_API_URL)?limit=10")!
            )

            return try JSONDecoder().decode(Recipes.self, from: res).recipes
        } catch {
            print("Failed to fetch recipes: \(error)")
            return []
        }
    }
}
