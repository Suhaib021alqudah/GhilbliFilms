//
//  FilmsViewModel.swift
//  GhibliFilms
//
//  Created by Trainee on 27/08/2026.
//

import Foundation
import Observation

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

@Observable
class FilmsViewModel {

    //MARK: - State Enum
    enum State: Equatable {
        case idle
        case loading
        case loaded([Film])
        case error(String)

    }

    var state: State = .idle
    var films: [Film] = []

    private let service: GhibliService
    init(service: GhibliService = DefaultGhibliService()) {

        self.service = service
    }

    //MARK: - fetch() Function
    func fetch() async {
        guard state == .idle else { return }
        state = .loading
        do {
            let films = try await service.fetchFilms()
            self.state = .loaded(films)
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "Unknown Error")

        } catch {
            self.state = .error("Unknown Error")
        }

    }

}
