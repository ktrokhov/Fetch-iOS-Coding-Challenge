//
//  MealsView.swift
//  FetchExercise
//
//  Created by Kirill Trokhov on 1/4/24.
//

import SwiftUI

struct MealsView: View {
    @Binding var selectedTab: AppTab
    @StateObject var viewModel = MealsViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                switch viewModel.viewState {
                case .loading:
                    MealLoadingView()

                case .success(let meals):
                    MealsContentView(meals: meals)

                case .error:
                    Text("No meals available.")

                case .empty:
                    Text("No meals available.")
                }
            }
            .navigationTitle("Desserts")
            .refreshable {
                viewModel.loadMeals()
            }
        }
    }
}
