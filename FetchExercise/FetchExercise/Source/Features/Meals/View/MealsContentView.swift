//
//  MealsContentView.swift
//  FetchExercise
//
//  Created by Kirill Trokhov on 1/6/24.
//

import SwiftUI

struct MealsContentView: View {
    let meals: [MealSummary]

    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
            ForEach(meals) { meal in
                NavigationLink(destination: MealDetailView(mealId: meal.id)) {
                    MealViewCell(meal: meal)
                }
            }
        }
    }
}
