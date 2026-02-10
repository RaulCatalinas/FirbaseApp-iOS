//
//  ApiManager.swift
//  FirbaseApp
//
//  Created by Tardes on 9/2/26.
//

import Foundation

final class ApiManager {
    private static var recipesOffset = 0
    private static let limit = 10

    static func resetPagination() {
        recipesOffset = 0
    }

    static func getRecipes() async -> Recipes? {
        do {
            let queryParams: [URLQueryItem] = [
                URLQueryItem(name: "limit", value: String(limit)),
                URLQueryItem(name: "skip", value: String(recipesOffset)),
            ]

            guard var urlComponents = URLComponents(string: "\(BASE_API_URL)")
            else { return nil }

            urlComponents.queryItems = queryParams

            let (res, _) = try await URLSession.shared.data(
                from: urlComponents.url!
            )
            let decoded = try JSONDecoder().decode(Recipes.self, from: res)

            if !decoded.recipes.isEmpty {
                recipesOffset += 10
            }

            return decoded
        } catch {
            print("Failed to fetch recipes: \(error)")
            return nil
        }
    }
}

