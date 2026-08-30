//
//  MockGhibliService.swift
//  GhibliFilms
//
//  Created by Trainee on 29/08/2026.
//

import Foundation

struct MockGhibliService: GhibliService {

    //MARK: - Mock Sample Data

    private struct SampleData: Decodable {
        let films: [Film]
        let people: [Person]
    }

    //MARK: - loadSampleData()
    private func loadSampleData() async throws -> SampleData {
        guard
            let url = Bundle.main.url(
                forResource:
                    "SampleData",
                withExtension: "json"
            )
        else {
            throw APIError.invalidURL
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(SampleData.self, from: data)

        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }

    }

    //MARK: - fetchFilms()
    func fetchFilms() async throws -> [Film] {
        let data = try await loadSampleData()
        return data.films
    }
    //MARK: - Preview/testing only()
    func fetchFilm() async throws -> Film {
        let data = try! await loadSampleData()
        return data.films.first!
    }
    //MARK: - fetchPerson()
    func fetchPerson(from URLString: String) async throws -> Person {
        let data = try await loadSampleData()
        return data.people.first!
    }

}
