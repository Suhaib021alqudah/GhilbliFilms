//
//  TabView.swift
//  GhibliFilms
//
//  Created by Trainee on 03/09/2026.
//

import SwiftUI

struct TabView: View {
    @State private var filmsViewModel  = FilmsViewModel()
    var body: some View {
        SwiftUI.TabView {
            Tab("Movies", systemImage: "movieclapper.fill") {
                FilmsView(filmsViewModel: filmsViewModel)
            }
            Tab("Favorite", systemImage: "heart") {
                FavoriteView()
            }
            Tab("Settings", systemImage: "gear") {
                SettingsView()
            }
          
            Tab(
    
                role: .search
            ) {
                SearchView()
            }

        }
    }
}

#Preview {
    TabView()
}
