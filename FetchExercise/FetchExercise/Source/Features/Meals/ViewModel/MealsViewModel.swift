//
//  MealsViewModel.swift
//  FetchExercise
//
//  Created by Kirill Trokhov on 1/5/24.
//

import SwiftUI

enum MealsViewState {
    case loading
    case success([MealSummary])
    case error
    case empty
}

@MainActor
class MealsViewModel: ObservableObject {

    // MARK: - Properties

    @Published var viewState: MealsViewState = .loading

    // MARK: - Private properties

    private let networkManager = DependencyContainer.resolve(type: NetworkManageable.self)

    // MARK: - Initialization

    init() {
        loadMeals()
    }

    // MARK: - Functions

    func loadMeals() {
        viewState = .loading

        Task {
            do {
                let items = try await networkManager.fetchDesserts()
                try? await DelayUtility.sleep(for: 2)

                if items.isEmpty {
                    viewState = .empty
                } else {
                    viewState = .success(items)
                }
            } catch {
                viewState = .error
                print("Error fetching meals: \(error)")
            }
        }
    }
}
