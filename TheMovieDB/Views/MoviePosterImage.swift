//
//  MoviePoster.swift
//  TheMovieDB
//
//  Created by ibrahim on 25/07/20.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import SwiftUI

struct MoviePosterImage: View {
    
    let url: URL
    let imageDownloader = ImageDowloader()
    @State var image: UIImage? = nil

    var body: some View {
        ZStack {
                makeContent()
            }
            .onReceive(imageDownloader.objectWillChange, perform: { image in
                self.image = image
            })
            .onAppear(perform: {
                self.imageDownloader.load(url: self.url)
            })
            .onDisappear(perform: {
                self.imageDownloader.cancel()
            })
    }
    
    private func makeContent() -> some View {
        if let image = image {
            return AnyView(
                Image(uiImage: image)
                    .resizable()
                    .renderingMode(.original)
            )
        } else {
            return AnyView(
                Rectangle()
                .foregroundColor(.gray)
            )
        }
    }
}


#if DEBUG
struct MoviePosterImage_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterImage(url: URL(string: "https://image.tmdb.org/t/p/w500/jHo2M1OiH9Re33jYtUQdfzPeUkx.jpg")!)
    }
}
#endif
