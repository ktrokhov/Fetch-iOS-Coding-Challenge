//
//  MealLoadingView.swift
//  FetchExercise
//
//  Created by Kirill Trokhov on 1/6/24.
//

import SwiftUI

struct MealLoadingView: View {
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
            ForEach(0..<6, id: \.self) { _ in
                ShimmeringView()
                    .frame(height: 250)
                    .background(.thinMaterial)
                    .cornerRadius(20)
            }
        }
    }
}
