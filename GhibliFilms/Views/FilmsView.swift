//
//  MoviesView.swift
//  GhibliFilms
//
//  Created by Trainee on 03/09/2026.
//

import SwiftUI

struct FilmsView: View {
    let filmsViewModel: FilmsViewModel

    var body: some View {
        NavigationStack {
            FilmListView(filmsViewModel: filmsViewModel)
            
                .navigationTitle("Ghibli Movies")
        }.task {
            await filmsViewModel.fetch()
            
        }
    }
}

#Preview {

    FilmsView(filmsViewModel: FilmsViewModel(service: MockGhibliService()))
}
