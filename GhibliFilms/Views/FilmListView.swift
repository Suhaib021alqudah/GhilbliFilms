//
//  FilmSwift.swift
//  GhibliFilms
//
//  Created by Trainee on 27/08/2026.
//

import SwiftUI

struct FilmListView: View {

    //MARK: - films : [Film]
    // Pass it instead of initialized it (Dependecy Injection)
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
                List(films) {
                    Text($0.title)
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
        service: MockGhibliService()
    )
    FilmListView(filmsViewModel: viewModel)
}
