//
//  FilmView.swift
//  GhibliFilms
//
//  Created by Trainee on 02/09/2026.
//

import SwiftUI

struct FilmImageView: View {
    let imageURL: String
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(12)
                
            case .failure:
                VStack(spacing: 8) {
                    Image(systemName: "wifi.slash")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    Text("Image unavailable")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview("Poster Image") {
    FilmImageView(
        imageURL:
            "https://image.tmdb.org/t/p/w600_and_h900_bestv2/rtGDOeG9LzoerkDGZF9dnVeLppL.jpg"
    )
}
#Preview("Bannaer Image") {
    FilmImageView(
        imageURL:
            "https://image.tmdb.org/t/p/original/etqr6fOOCXQOgwrQXaKwenTSuzx.jpg"
    )
}
