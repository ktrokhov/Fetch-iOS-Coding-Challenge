//
//  ContentView.swift
//  FetchExercise
//
//  Created by Kirill Trokhov on 1/4/24.
//

import SwiftUI

public struct ContentView: View {
    
    // MARK: - Properties

    @EnvironmentObject var tabViewModel: TabViewModel
    
    // MARK: - Private properties

    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)

    // MARK: - View

    public var body: some View {
        TabView(selection: $tabViewModel.selectedTab) {
            ForEach(AppTab.allCases, id: \.self) { tab in
                tab.view(selectedTab: $tabViewModel.selectedTab)
                    .tabItem {
                        Label(tab.label, systemImage: tab.systemImage)
                    }
                    .onChange(of: tabViewModel.selectedTab) { newTab in
                        if newTab == tab {
                            triggerHapticFeedback()
                        }
                    }
            }
        }
        .accentColor(.orange)
        .onAppear { setTabBarAppearance() }
    }

    // MARK: - Private functions

    private func setTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor.lightText
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    private func triggerHapticFeedback() {
        feedbackGenerator.impactOccurred()
    }
}

struct ContentViewPreview: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(TabViewModel())
    }
}
