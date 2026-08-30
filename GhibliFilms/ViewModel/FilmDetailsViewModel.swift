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
    var people: [Person] = []
    let service: GhibliService

    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }

    // MARK: - fetch function
    func fetch(for film: Film) async {
        //let urls =   film.people

        do {
            try await withThrowingTaskGroup(of: Person.self) { group in
                for personInfoURL in film.people {
                    group.addTask {
                        try await self.service.fetchPerson(from: personInfoURL)

                    }
                }
                for try await person in group {
                    people.append(person)
                }
            }
        } catch {}

    }
}

#Playground {

    let viewModel = FilmDetailsViewModel()
    let film = try await MockGhibliService().fetchFilm()
    await viewModel.fetch(for: film)
    for person in viewModel.people {
        print(viewModel.people)
    }
}
 
