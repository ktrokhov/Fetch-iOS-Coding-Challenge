//
//  MealDetailLoadingView.swift
//  FetchExercise
//
//  Created by Kirill Trokhov on 1/6/24.
//

import SwiftUI

struct MealDetailLoadingView: View {
    private let shimmeringLines = 4

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ShimmeringView()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .background(.thinMaterial)
                .cornerRadius(20)

            ForEach(0..<shimmeringLines, id: \.self) { _ in
                ShimmeringView()
                    .frame(height: 40)
                    .background(.thinMaterial)
                    .cornerRadius(20)
            }
        }
    }
}
