//
//  FavouriteMovieService.swift
//  TheMovieDB
//
//  Created by ibrahim on 26/07/20.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import Foundation

public class FavouriteMovieService{

   private let defaults = UserDefaults.standard
   
    // get favourited movie on local storage
    func getFavourites()->[Int]{
        
        guard let favourites = defaults.array(forKey: "favourites") as? [Int] else {
            return [Int]()
        }
        
        return favourites
    }
    
    // check if movie is favourited
    func isFavourite(id:Int) -> Bool{
        return getFavourites().contains(id)
    }
    
    // set movie as favourite by id
    func setFavourite(id:Int) {
        // get all favourites
        var favourites = getFavourites()
        // add new favourite to local storage
        favourites.append(id)
        defaults.set(favourites, forKey: "favourites")
        defaults.synchronize()
    }
    
    // remove favourited movie by id
    func removeFavourite(id:Int) {
        // get all favourites
        let favourites = getFavourites()
        // remove from local storage
        defaults.set(favourites.filter{$0 != id}, forKey: "favourites")
        defaults.synchronize()
    }
    
    func cleanFavourites(){
        defaults.set(nil, forKey: "favourites")
        defaults.synchronize()
    }
}
