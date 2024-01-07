//
//  MealDetailModel.swift
//  FetchExercise
//
//  Created by Kirill Trokhov on 1/6/24.
//

import Foundation

struct MealDetailResponse: Codable {
    let meals: [MealDetail]
}

struct MealDetail: Codable {

    // MARK: - Properties

    var idMeal: String?
    var strMeal: String?
    var strInstructions: String?
    var strMealThumb: String?
    var ingredientMeasures: [IngredientMeasure] = []

    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strInstructions, strMealThumb
    }

    struct IngredientMeasure: Codable {
        var ingredient: String
        var measure: String
    }

    // MARK: - Initialization

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decodeIfPresent(String.self, forKey: .idMeal)
        strMeal = try container.decodeIfPresent(String.self, forKey: .strMeal)
        strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        strMealThumb = try container.decodeIfPresent(String.self, forKey: .strMealThumb)

        ingredientMeasures = try decodeIngredientsAndMeasures(from: decoder)
    }

    // MARK: - Private functions

    private func decodeIngredientsAndMeasures(from decoder: Decoder) throws -> [IngredientMeasure] {
        var measures = [IngredientMeasure]()
        let additionalContainer = try decoder.container(keyedBy: AdditionalCodingKeys.self)

        for index in 1... {
            let ingredientKey = AdditionalCodingKeys(stringValue: "strIngredient\(index)")
            let measureKey = AdditionalCodingKeys(stringValue: "strMeasure\(index)")

            guard let ingredientKey = ingredientKey, let measureKey = measureKey,
                  let ingredient = try additionalContainer.decodeIfPresent(String.self, forKey: ingredientKey),
                  !ingredient.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                      break
                  }

            let measure = try additionalContainer.decodeIfPresent(String.self, forKey: measureKey) ?? ""
            measures.append(IngredientMeasure(ingredient: ingredient, measure: measure))
        }

        return measures
    }

    private struct AdditionalCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?

        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        init?(intValue: Int) {
            self.stringValue = "strIngredient\(intValue)"
            self.intValue = intValue
        }
    }
}
