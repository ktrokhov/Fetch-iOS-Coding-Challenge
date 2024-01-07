//
//  MealDetailViewModel.swift
//  FetchExercise
//
//  Created by Kirill Trokhov on 1/6/24.
//

import Foundation
import SwiftUI

enum MealDetailState {
    case loading
    case success(MealDetailWithImage)
    case error(String)
    case none
}

struct MealDetailWithImage {
    let mealDetail: MealDetail
    let mealImage: UIImage?
}

@MainActor
class MealDetailViewModel: ObservableObject {

    // MARK: - Properties

    @Published var viewState: MealDetailState = .none

    // MARK: - Private properties

    private let networkManager = DependencyContainer.resolve(type: NetworkManageable.self)

    // MARK: - Functions

    func fetchMealDetail(mealID: String) {
        viewState = .loading
        Task {
            do {
                async let mealData = fetchMealData(mealID)
                try await DelayUtility.sleep(for: 1.5)
                let (mealDetail, mealImage) = try await mealData
                self.viewState = .success(MealDetailWithImage(mealDetail: mealDetail, mealImage: mealImage))
            } catch {
                self.viewState = .error(error.localizedDescription)
            }
        }
    }

    // MARK: - Private functions

    private func fetchMealData(_ mealID: String) async throws -> (MealDetail, UIImage?) {
        let mealDetail = try await networkManager.fetchMealDetail(mealID: mealID)
        var mealImage: UIImage? = nil
        if let imageURLString = mealDetail.strMealThumb, let imageURL = URL(string: imageURLString) {
            mealImage = try await networkManager.downloadImage(from: imageURL)
        }
        return (mealDetail, mealImage)
    }
}
