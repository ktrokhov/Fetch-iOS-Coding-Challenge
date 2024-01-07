//
//  FetchExerciseAppDelegate.swift
//  FetchExercise
//
//  Created by Kirill Trokhov on 1/4/24.
//

import UIKit

class FetchExerciseAppDelegate: NSObject, UIApplicationDelegate {
    
    // MARK: - Functions

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        registerDependencies()

        return true
    }

    // MARK: - Private Functions

    private func registerDependencies() {
        DependencyContainer.register(
            type: NetworkManageable.self,
            dependency: NetworkManager()
        )
    }
}
