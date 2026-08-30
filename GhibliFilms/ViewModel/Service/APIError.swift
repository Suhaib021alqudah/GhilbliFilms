//
//  APIError.swift
//  GhibliFilms
//
//  Created by Trainee on 30/08/2026.
//

import Foundation
//MARK: - API Error
enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decoding(Error)
    case networkError(Error)

    var errorDescription: String? {
        switch self {

        case .invalidURL:
            return "The URL is invalid"
        case .invalidResponse:
            return "Invalid Response from the Server"

        case .decoding(let error):
            return
                "Failed to decode response : \(error.localizedDescription)"

        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}
