//
//  MovieCell.swift
//  TheMovieDB
//
//  Created by ibrahim on 24/07/20.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import SwiftUI

let BASE_IMAGE_URL = "https://image.tmdb.org/t/p/original/"

struct MovieCell: View {
    
    var movie: Movie
    @State var isFavourite : Bool = false
    
    init(movie:Movie) {
        self.movie = movie
        self.isFavourite = FavouriteMovieService().isFavourite(id: movie.id)
    }
    
    var body: some View {
        HStack(spacing: 10) {
            MoviePosterImage(url: movie.posterURL)
                .frame(width: 120, height: 180)
                .cornerRadius(5)
                .shadow(radius: 10)
            VStack(alignment: .leading, spacing: 10) {
                HStack{
                    Text(movie.title)
                        .foregroundColor(.fontTheme)
                        .font(.headline)
                        Spacer()
                        if isFavourite {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        }
                }
                Text(movie.cleanMovieReleaseDate)
                    .foregroundColor(.fontTheme)
                    .font(.subheadline)
                Text(movie.overview)
                    .font(.subheadline)
                    .foregroundColor(.fontTheme)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
        }.onAppear{
            // update is favourite status
            self.isFavourite = FavouriteMovieService().isFavourite(id: self.movie.id)
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(Color.viewTheme)
        .cornerRadius(5)
        .shadow(radius: 5)
    }
}

#if DEBUG
struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieCell(movie: Movie.dummy)
    }
}
#endif
