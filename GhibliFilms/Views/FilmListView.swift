//
//  FilmSwift.swift
//  GhibliFilms
//
//  Created by Trainee on 27/08/2026.
//

import SwiftUI

struct FilmListView: View {

    //MARK: - films
    
    var filmsViewModel: FilmsViewModel = FilmsViewModel()

    var body: some View {
        NavigationStack {
            switch filmsViewModel.state
            {
            case .idle:
                Text("No Films Yet")
            case .loading:
                ProgressView {
                    Text("Loading")
                }
            case .loaded(let films):
                List(films) { film in
                    NavigationLink(value: film) {
                        HStack {
                            FilmImageView(imageURL: film.image)
                                .frame(width: 100, height: 150)

                            Text(
                                film.title
                            ).padding(.horizontal)
                        }
                    }

                }.navigationDestination(for: Film.self) {
                    film in
                    FilmDetailView(film: film)
                }

            case .error(let error):
                Text(error).foregroundStyle(.red)
            }
        }
        .task {
            await filmsViewModel.fetch()

        }

    }
}

#Preview {
    @State @Previewable var viewModel = FilmsViewModel(
        service: DefaultGhibliService()
    )
    FilmListView(filmsViewModel: viewModel)
}
