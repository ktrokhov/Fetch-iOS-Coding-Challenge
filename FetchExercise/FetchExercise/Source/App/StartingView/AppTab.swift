//
//  AppTab.swift
//  FetchExercise
//
//  Created by Kirill Trokhov on 1/4/24.
//

import SwiftUI

enum AppTab: CaseIterable {
    case meal

    var label: String {
        switch self {
        case .meal:
            return "Meals"
        }
    }

    var systemImage: String {
        switch self {
        case .meal:
            return "fork.knife.circle.fill"
        }
    }

    @ViewBuilder
    func view(selectedTab: Binding<AppTab>) -> some View {
        switch self {
        case .meal:
            MealsView(selectedTab: selectedTab)
        }
    }
}
