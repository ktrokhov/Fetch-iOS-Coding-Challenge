//
//  MealViewCell.swift
//  FetchExercise
//
//  Created by Kirill Trokhov on 1/5/24.
//

import SwiftUI

struct MealViewCell: View {
    let meal: MealSummary

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: meal.strMealThumb), transaction: .init(animation: .bouncy(duration: 1))) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .cornerRadius(20)
                        .padding(.bottom, 10)
                case .failure:
                    Text("Failed to load image")
                case .empty:
                    ProgressView()
                        .frame(width: 100, height: 100)
                @unknown default:
                    EmptyView()
                }
            }

            Text(meal.strMeal)
                .font(.system(size: 13, weight: .bold))
                .multilineTextAlignment(.center)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.bottom, 10)
                .frame(height: 50)
        }
        .background(.thinMaterial)
        .cornerRadius(20)
    }
}
