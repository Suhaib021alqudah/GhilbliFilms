//
//  FilmsViewModel.swift
//  GhibliFilms
//
//  Created by Trainee on 27/08/2026.
//

import Foundation
import Observation

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
