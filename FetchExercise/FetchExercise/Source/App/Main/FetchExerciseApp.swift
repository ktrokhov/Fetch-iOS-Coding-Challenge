//
//  FetchExerciseApp.swift
//  FetchExercise
//
//  Created by Kirill Trokhov on 1/4/24.
//

import SwiftUI

@main
struct FetchExerciseApp: App {
    @UIApplicationDelegateAdaptor(FetchExerciseAppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(TabViewModel())
        }
    }
}

struct ContentViews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TabViewModel())
    }
}
