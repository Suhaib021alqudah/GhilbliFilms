//
//  FilmDetailsViewModel.swift
//  GhibliFilms
//
//  Created by Trainee on 30/08/2026.
//

import Foundation
import Observation
import Playgrounds

@Observable
class FilmDetailsViewModel {

    //MARK: - State Enum
    enum State: Equatable {
        case idle  // Not start loading yet
        case loading
        case loaded([Person])
        case error(String)

    }

    var state: State = .idle
    var people: [Person] = []
    let service: GhibliService

    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }

    // MARK: - fetch function
    func fetch(for film: Film) async {
        guard state != .loading else { return }
        state = .loading
        var loadedPeople: [Person] = []
        do {
            try await withThrowingTaskGroup(of: Person.self) { group in
                for personInfoURL in film.people {
                    group.addTask {

                        try await self.service.fetchPerson(
                            from: personInfoURL
                        )

                    }
                }
                for try await person in group {
                    loadedPeople.append(person)

                }
                state = .loaded(loadedPeople)
            }

        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "Unknown Error")

        } catch {
            self.state = .error("Unknown Error")
        }

    }
}

#Playground {
    let mockService = MockGhibliService()
    let viewModel = FilmDetailsViewModel(service: mockService )
    let film = try await MockGhibliService().fetchFilm()
    await viewModel.fetch(for: film)

    switch viewModel.state {
    case .idle: print("idle")
    case .loading: print("loading")
    case .loaded(let people):
        for person in people {
            print(person)
        }

    case .error(let error): print(error)

    }

}
