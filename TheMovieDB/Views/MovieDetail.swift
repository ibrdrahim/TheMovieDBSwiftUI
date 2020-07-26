//
//  MovieDetail.swift
//  TheMovieDB
//
//  Created by ibrahim on 25/07/20.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import SwiftUI

struct MovieDetail: View {
    
    @ObservedObject var movieDetail  : DetailMovieData
    
    var body: some View {
        makeMovieDetailContent()
            .onAppear{
                self.movieDetail.fetchData()
            }
    }
    
    private func makeMovieDetailContent() -> some View{
        return AnyView(
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment:.leading,spacing: 20){
                    makeMovieContent()
                    makeReviewsContent()
                    Spacer()
                }
                .padding(10)
                .frame(maxWidth: .infinity)
            }
        )
    }
    
    private func makeMovieContent() -> some View {
        if let movie = movieDetail.movie {
            return AnyView( VStack(alignment: .leading, spacing: 20.0){
                HStack(alignment:.top,spacing: 20) {
                    MoviePosterImage(url: movie.posterURL)
                        .frame(width: 160, height: 320)
                        .cornerRadius(5)
                        .shadow(radius: 10)
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(){
                            VStack(alignment:.leading){
                                Text(movie.title)
                                    .foregroundColor(.fontTheme)
                                    .font(.headline)
                                Text(movie.cleanMovieReleaseDate)
                                    .foregroundColor(.fontTheme)
                                    .font(.subheadline)
                            }
                            Spacer()
                            Button(action: {
                                self.movieDetail.toggleFavourite()
                            }){
                                Image(systemName: movieDetail.isFavourite ?  "heart.fill" : "heart")
                                    .accentColor(.red)
                            }
                        }
                        Text("Overview")
                            .foregroundColor(.fontTheme)
                            .font(.subheadline)
                        Text(movie.overview)
                            .font(.subheadline)
                            .foregroundColor(.fontTheme)
                            .multilineTextAlignment(.leading)
                            .lineLimit(10)
                        }
                }
                .navigationBarTitle(movie.title)
                .padding(10)
                .background(Color.viewTheme)
                .cornerRadius(10)
                .shadow(radius: 10)
            })
            
        }else{
            return AnyView(
                    Text("Fetching Movie Detail ....")
                    .foregroundColor(.fontTheme)
            )
        }
    }
    
    private func makeReviewsContent() -> some View {
        if let reviews = movieDetail.reviews {
            return AnyView(
                VStack(alignment: .leading, spacing: 10){
                    Text("Reviews")
                    .foregroundColor(.fontTheme)
                    .font(.headline)
                    if reviews.count > 0 {
                        ForEach(reviews, id: \.self) {
                            review in
                            ReviewCell(review: review)
                        }
                    }else{
                        Text("This movie doesn't have any review.")
                        .foregroundColor(.fontTheme)
                    }
                }
            )
        }else{
            return AnyView(
                Text("Fetching Reviews ....")
                .foregroundColor(.fontTheme)
            )
        }
    }
}

//#if DEBUG
//struct MovieDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetail(movie: Movie.dummy)
//    }
//}
//#endif
