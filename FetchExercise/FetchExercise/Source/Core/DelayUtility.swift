//
//  DelayUtility.swift
//  FetchExercise
//
//  Created by Kirill Trokhov on 1/5/24.
//

import Foundation

struct DelayUtility {
    static func sleep(for duration: TimeInterval) async throws {
        let nanoseconds = UInt64(duration * 1_000_000_000)
        try await Task.sleep(nanoseconds: nanoseconds)
    }
}
