//
//  NetworkManager.swift
//  FetchExercise
//
//  Created by Kirill Trokhov on 1/5/24.
//

import Foundation
import SwiftUI

enum APIServiceError: Error {
    case invalidURL
    case invalidResponse
    case statusCodeNotSuccess
    case decodingError
    case imageDownloadError
}

struct APIConfig {
    static let baseURL = URL(string: "https://www.themealdb.com/api/json/v1/1")!
    static let timeoutInterval: TimeInterval = 10
}

class NetworkManager: NetworkManageable {
    
    // MARK: - Private properties

    private let urlSession =  URLSession(configuration: URLSessionConfiguration.default)

    // MARK: - Initialization

    init() {}

    // MARK: - Functions

    func fetchDesserts() async throws -> [MealSummary] {
        let meals = try await request(endpoint: "/filter.php", parameters: ["c": "Dessert"], responseType: MealListResponse.self)
        return meals.meals.sorted { $0.strMeal < $1.strMeal }
    }

    func fetchMealDetail(mealID: String) async throws -> MealDetail {
        let response = try await request(endpoint: "/lookup.php", parameters: ["i": mealID], responseType: MealDetailResponse.self)
        guard let mealDetail = response.meals.first else {
            throw APIServiceError.invalidResponse
        }
        return mealDetail
    }
    
    func downloadImage(from imageURL: URL?) async throws -> UIImage {
        guard let imageURL = imageURL else {
            throw APIServiceError.invalidURL
        }
        
        let (data, _) = try await urlSession.data(from: imageURL)
        
        guard let image = UIImage(data: data) else {
            throw APIServiceError.imageDownloadError
        }
        
        return image
    }

    // MARK: - Private functions

    private func request<T: Decodable>(endpoint: String, parameters: [String: String], responseType: T.Type) async throws -> T {
        guard var urlComponents = URLComponents(url: APIConfig.baseURL.appendingPathComponent(endpoint),resolvingAgainstBaseURL: true) else {
            throw APIServiceError.invalidURL
        }

        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = urlComponents.url else {
            throw APIServiceError.invalidURL
        }

        var request = URLRequest(url: url)
        request.timeoutInterval = APIConfig.timeoutInterval

        let (data, response) = try await urlSession.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw APIServiceError.statusCodeNotSuccess
        }

        do {
            return try JSONDecoder().decode(responseType, from: data)
        } catch {
            throw APIServiceError.decodingError
        }
    }
}
