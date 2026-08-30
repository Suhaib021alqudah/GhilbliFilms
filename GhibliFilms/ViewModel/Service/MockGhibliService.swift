//
//  MockGhibliService.swift
//  GhibliFilms
//
//  Created by Trainee on 29/08/2026.
//

import Foundation

struct MockGhibliService : GhibliService {
    func fetchFilms() async throws -> [Film] {
        return [] 
    }

    
}
