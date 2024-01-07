//
//  TableViewModel.swift
//  FetchExercise
//
//  Created by Kirill Trokhov on 1/4/24.
//

import Foundation

class TabViewModel: ObservableObject {
    @Published var selectedTab: AppTab = .meal
}
