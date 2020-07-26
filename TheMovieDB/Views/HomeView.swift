//
//  ContentView.swift
//  TheMovieDB
//
//  Created by ibrahim on 24/07/20.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State private var expandCategory = false
    @ObservedObject var movieData: MovieHomeData
    
    init(movieData:MovieHomeData) {
        // create custom navbar, to change navigation view color to blue
        let customNavBar = UINavigationBarAppearance()

        customNavBar.configureWithOpaqueBackground()
        customNavBar.backgroundColor = UIColor(named: "MainThemeColor")
        customNavBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        customNavBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = customNavBar
        UINavigationBar.appearance().scrollEdgeAppearance = customNavBar
        self.movieData = movieData
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                
               if movieData.isLoading {
                    Text("Fetching Content ...")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .background(Color.viewTheme)
                    .foregroundColor(.fontTheme)
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(100)
                }

                VStack {
                    if movieData.movies.count > 0 {
                        MovieList(movies: movieData.movies) { id in
                            // check if equal to current last movie
                            if let last = self.movieData.movies.last, last.id == id {
                                self.movieData.loadMoreMovies()
                            }
                        }
                    }
                    makeCategoryPicker()
                }
            }
            .navigationBarTitle("TheMovieDB Kitabisa.com",displayMode: .inline)
            .navigationBarItems(
                trailing:
                NavigationLink(destination: FavouriteMovieView(favouriteMovieData: FavouriteMovieData() )) {
                    Image(systemName: "heart.fill")
                }
            )
        }
        .accentColor(.white)
    }
    
    private func makeCategoryPicker() -> some View {
        return AnyView(
            ZStack(alignment: .bottom){

                Button(action:{
                    self.expandCategory.toggle()
                }){
                    Text("Category : \(movieData.activeCategory.rawValue.replacingOccurrences(of: "_", with: " ").capitalized)")
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .background(Color.mainTheme)
                
                if expandCategory {
                    VStack(){
                        ForEach(MovieEndpoint.allCases) { category in
                            Button(action:{
                                self.expandCategory.toggle()
                                self.movieData.loadMovies(category)
                            }){
                                Text(category.rawValue.replacingOccurrences(of: "_", with: " ").capitalized)
                                    .foregroundColor(Color.fontTheme)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                            }
                            .background(Color.viewTheme)
                        }
                    }
                }
            }
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(movieData: MovieHomeData())
    }
}
