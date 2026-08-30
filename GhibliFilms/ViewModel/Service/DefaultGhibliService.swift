//
//  DefualtGhibliService.swift
//  GhibliFilms
//
//  Created by Trainee on 29/08/2026.
//

import Foundation

/*
   The Services layers only holds pure functinos like fetchFilms() function
   that dont hold any mutable state that can change during the run time
   this help us to use different implementations

   Sometimes we will facing situations where we need to have  a state
   for example : A token refersh flow where we have to fetch the token
   or access token.
   In this case we would have a mutable state in these situation we will
   do it in classes.
*/

struct DefaultGhibliService: GhibliService {

    //MARK: - fetch() Function
    func fetch<T: Decodable>(from URLString: String, type: T.Type) async throws
        -> T
    {
        guard let url = URL(string: URLString) else {
            throw APIError.invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
                throw APIError.invalidResponse
            }
            return try JSONDecoder().decode(type.self, from: data)

        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }

    }

    //MARK: - fetchFilms() Function
    func fetchFilms() async throws -> [Film] {
        let url = "https://ghibliapi.vercel.app/films"
        return try await fetch(from: url, type: [Film].self)
    }

    //MARK: - fetchPerson() Function
    func fetchPerson(from URLString: String) async throws -> Person {
        return try await fetch(from: URLString, type: Person.self)
    }

}
