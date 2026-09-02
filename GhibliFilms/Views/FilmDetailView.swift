//
//  FilmDetailView.swift
//  GhibliFilms
//
//  Created by Trainee on 02/09/2026.
//

import SwiftUI

struct FilmDetailView: View {
    let film: Film
    @State private var filmDetailViewModel = FilmDetailsViewModel()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // MARK: - Image
                FilmImageView(imageURL: film.bannerImage)
                   
                
                //MARK: - Movie Name
                Text("Movie Name : \(film.title)").font(.title3)
                Divider()
                
                //MARK: - Characters
                Text("Chatacters : ").padding(.top)
                switch filmDetailViewModel.state {
                case .idle:
                    EmptyView()
                case .loading:
                    ProgressView()
                case .loaded(let people):
                    ForEach(people) { person in
                        Text(person.name)
                    }
                    
                case .error(let error):
                    Text(error).foregroundStyle(.red)
                }
                
                Spacer()
            }.task(id: film) {
                await filmDetailViewModel.fetch(for: film)
            }.padding(.horizontal, 10)
        }
    }
}

#Preview {
    FilmDetailView(film: Film.example)
}
