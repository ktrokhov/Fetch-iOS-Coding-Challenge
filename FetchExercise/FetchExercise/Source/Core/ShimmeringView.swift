//
//  ShimmeringView.swift
//  FetchExercise
//
//  Created by Kirill Trokhov on 1/5/24.
//

import SwiftUI

struct ShimmeringView: View {
    var body: some View {
        Rectangle()
            .fill(Color.black.opacity(0.8))
            .cornerRadius(20)
            .shimmering()
    }
}

extension View {
    func shimmering() -> some View {
        self.modifier(ShimmerEffect())
    }
}

struct ShimmerEffect: ViewModifier {
    @State private var phase: CGFloat = -UIScreen.main.bounds.width

    func body(content: Content) -> some View {
        content
            .mask(
                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.white.opacity(0.5), Color.clear]), startPoint: .leading, endPoint: .trailing)
                    .offset(x: phase)
            )
            .onAppear {
                withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                    phase = UIScreen.main.bounds.width
                }
            }
    }
}
