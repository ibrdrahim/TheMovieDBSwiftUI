# TheMovieDBSwiftUI
The Movie DB App with swiftUI

## Main Features :
* User is able to see list of movies based on these preferences (popular, top rated, now playing)
  Get Popular 
  https://developers.themoviedb.org/3/movies/get-popular-movies
  Get Top Rated
  https://developers.themoviedb.org/3/movies/get-top-rated-movies
  Get Now Playing
  https://developers.themoviedb.org/3/movies/get-now-playing
  User is able to see movie detail (contains of poster image, synopsis, list of reviews, favorite button)
  Get Movie Details
  https://developers.themoviedb.org/3/movies/get-movie-details
* List of reviews for a movie can be fetched from this endpoint https://developers.themoviedb.org/3/movies/get-movie-reviews
* User is able to add a movie to favorite from the movie detail screen (save to local)
* User is able to remove a movie from favorite from the movie detail screen (local)
* User is able to see the list of favorited movies in the Favorite screen (retrieved from saved favorite movies in local)

## Additional Features :
* Support dark mode, with custom color scheme
* Load more for more list of movie

## Notes
there is a known **Xcode bug exist** for swiftUI, when you open navigation link in **simulator** navigation link only trigger once for each unique screen,
but its safe on real device. 

## Tested And work in : Xcode 11.3.1 & Iphone X (13.1.2)
|
<img src="https://raw.githubusercontent.com/ibrdrahim/TheMovieDBSwiftUI/development/previews/dark_detail.jpg" width="300" height="600" />   |
<img src="https://raw.githubusercontent.com/ibrdrahim/TheMovieDBSwiftUI/development/previews/light_detail.jpg" width="300" height="600" />   |
|


<img src="https://raw.githubusercontent.com/ibrdrahim/TheMovieDBSwiftUI/development/previews/dark_list.jpg" width="300" height="600" />   |
<img src="https://raw.githubusercontent.com/ibrdrahim/TheMovieDBSwiftUI/development/previews/light_list.jpg" width="300" height="600" />   |
