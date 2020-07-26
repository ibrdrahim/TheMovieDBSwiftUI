//
//  FavouriteMovieView.swift
//  TheMovieDB
//
//  Created by ibrahim on 26/07/20.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import SwiftUI

struct FavouriteMovieView: View {
    
    @ObservedObject var favouriteMovieData: FavouriteMovieData
    
    var body: some View {
        makeContentView()
        .onAppear(){
            self.favouriteMovieData.loadFavouriteMovies()
        }
        .navigationBarTitle("Favourite Movie")
    }
    
    private func makeContentView() -> some View {
        if !favouriteMovieData.isLoading {
            if favouriteMovieData.movies.count > 0 {
                return AnyView(
                    List(favouriteMovieData.movies){ movie in
                        // create zstack and add empty view to override default listitem
                        ZStack {
                            NavigationLink(destination:
                                MovieDetail(movieDetail: DetailMovieData(id: movie.id))
                            ){
                                EmptyView()
                            }
                            MovieCell(movie: movie)
                        }
                    }.background(Color.gray)
                )
            }else{
                return AnyView(
                    Text("You don't have any favourite movie")
                    .foregroundColor(.fontTheme)
                )
            }
        }else{
            return AnyView(
                Text("Fetching favourite movies..")
                .foregroundColor(.fontTheme)
            )
        }
    }
}

struct FavouriteMovieView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteMovieView(favouriteMovieData: FavouriteMovieData())
    }
}
