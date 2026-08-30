//
//  Person.swift
//  GhibliFilms
//
//  Created by Trainee on 27/08/2026.
//

import Foundation
import Playgrounds

struct Person: Decodable, Identifiable ,Equatable {

    let id: String
    let name: String
    let gender: String
    let age: String
    let eyeColor: String
    let hairColor: String
    let films: [String]
    let species: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id, name, gender, age, films, species, url
        case eyeColor = "eye_color"
        case hairColor = "hair_color"
    }
}

#Playground {
    let url = URL(
        string:
            "https://ghibliapi.vercel.app/people/fe93adf2-2f3a-4ec4-9f68-5422f1b87c01"
    )!
    
    do {
        let (data, response) = try await
         URLSession.shared.data(from: url)

        try JSONDecoder().decode(Person.self, from: data)

    } catch {
        print(error)
    }
}
