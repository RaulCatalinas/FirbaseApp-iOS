// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let recipes = try? JSONDecoder().decode(Recipes.self, from: jsonData)

import Foundation

// MARK: - Recipes
struct Recipes: Codable {
    let recipes: [Recipe]
    let total, skip, limit: Int
}

// MARK: - Recipe
struct Recipe: Codable {
    let id: Int
    let name: String
    let ingredients, instructions: [String]
    let prepTimeMinutes, cookTimeMinutes, servings: Int
    let difficulty: Difficulty
    let cuisine: String
    let caloriesPerServing: Int
    let tags: [String]
    let userID: Int
    let image: String
    let rating: Double
    let reviewCount: Int
    let mealType: [String]

    enum CodingKeys: String, CodingKey {
        case id, name, ingredients, instructions, prepTimeMinutes,
            cookTimeMinutes, servings, difficulty, cuisine, caloriesPerServing,
            tags
        case userID = "userId"
        case image, rating, reviewCount, mealType
    }
}

enum Difficulty: String, Codable {
    case easy = "Easy"
    case medium = "Medium"
}
