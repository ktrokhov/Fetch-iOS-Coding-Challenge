//
//  MealDetailContentView.swift
//  FetchExercise
//
//  Created by Kirill Trokhov on 1/6/24.
//

import SwiftUI

struct MealDetailContentView: View {
    let mealDetail: MealDetail
    let mealImage: UIImage?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let mealImage = mealImage {
                    Image(uiImage: mealImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                }
                Text(mealDetail.strMeal ?? "")
                    .font(.largeTitle)

                Text("Ingredients")
                    .font(.title)
                VStack(spacing: 12) {
                    ForEach(0..<mealDetail.ingredientMeasures.count, id: \.self) { index in
                        let ingredientMeasure = mealDetail.ingredientMeasures[index]
                        HStack {
                            Text(ingredientMeasure.ingredient.capitalized)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(10)
                            Text(ingredientMeasure.measure)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(10)
                        }
                        .padding(10)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                    }
                }
                Text("Instructions")
                    .font(.title)
                Text(mealDetail.strInstructions ?? "")
                    .font(.body)
            }
            .padding()
        }
    }
}
