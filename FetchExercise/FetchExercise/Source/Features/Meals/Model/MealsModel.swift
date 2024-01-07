//
//  MealsModel.swift
//  FetchExercise
//
//  Created by Kirill Trokhov on 1/5/24.
//

import Foundation

struct MealListResponse: Codable {
    let meals: [MealSummary]
}

struct MealSummary: Codable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    var id: String { idMeal }
}
