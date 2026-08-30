//
//  GhibliService.swift
//  GhibliFilms
//
//  Created by Trainee on 29/08/2026.
//

import Foundation

protocol GhibliService: Sendable {

    func fetchFilms() async throws -> [Film]
    func fetchPerson(from URLString: String) async throws -> Person
}
