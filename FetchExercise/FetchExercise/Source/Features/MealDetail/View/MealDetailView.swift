//
//  MealDetailView.swift
//  FetchExercise
//
//  Created by Kirill Trokhov on 1/5/24.
//

import SwiftUI

struct MealDetailView: View {
    @StateObject var viewModel = MealDetailViewModel()
    var mealId: String

    init(mealId: String) {
        self.mealId = mealId
    }

    var body: some View {
        Group {
            switch viewModel.viewState {
            case .loading:
                MealDetailLoadingView()

            case .success(let mealDetailWithImage):
                MealDetailContentView(mealDetail: mealDetailWithImage.mealDetail, mealImage: mealDetailWithImage.mealImage)

            case .error(let errorMessage):
                Text("Error: \(errorMessage)")
                    .multilineTextAlignment(.center)
                    .padding()

            case .none:
                Text("No details available")
                    .padding()
            }
        }
        .navigationBarTitle("Meal Details", displayMode: .inline)
        .onAppear {
            viewModel.fetchMealDetail(mealID: mealId)
        }
    }
}
