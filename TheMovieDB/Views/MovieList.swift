//
//  MovieList.swift
//  TheMovieDB
//
//  Created by ibrahim on 25/07/20.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import SwiftUI

struct MovieList: View {
    
    var movies : [Movie]
    var isLastElement: ((_ id: Int) -> Void)
    
    var body: some View {
        List(movies){ movie in
            // create zstack and add empty view to override default listitem
            ZStack {
                NavigationLink(destination:
                    MovieDetail(movieDetail: DetailMovieData(id: movie.id))
                ){
                    EmptyView()
                }
                MovieCell(movie: movie)
                .onAppear{
                    // check if movie is last element to trigger load more data
                    if  let last = self.movies.last, last.id == movie.id  {
                        self.isLastElement(movie.id)
                    }
                }
            }
        }.background(Color.viewTheme)
    }
}

#if DEBUG
struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList(movies: Movie.dumies){_ in
            print("do nothing")
        }
    }
}
#endif
