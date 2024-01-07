//
//  NetworkManageable.swift
//  FetchExercise
//
//  Created by Kirill Trokhov on 1/6/24.
//

import Foundation
import UIKit

protocol NetworkManageable {
    func fetchDesserts() async throws -> [MealSummary]
    func fetchMealDetail(mealID: String) async throws -> MealDetail
    
    func downloadImage(from imageURL: URL?) async throws -> UIImage
}
