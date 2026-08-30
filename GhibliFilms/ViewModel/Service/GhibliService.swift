//
//  GhibliService.swift
//  GhibliFilms
//
//  Created by Trainee on 29/08/2026.
//

import Foundation

protocol GhibliService {
    
     func fetchFilms() async throws -> [Film]
}
