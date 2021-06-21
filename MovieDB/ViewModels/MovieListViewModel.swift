//
//  MovieListViewModel.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-21.
//

import Foundation

class MovieListViewModel: ObservableObject {
    static let fileKey = "SavedMovies"

    // TODO: convert to hashmap for faster lookup
    @Published var movies: [SavedMovie] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(movies) {
                UserDefaults.standard.set(encoded, forKey: MovieListViewModel.fileKey)
            }
        }
    }
    
    var reviewedMovies: [SavedMovie] {
        var res = [SavedMovie]()
        for movie in movies where movie.watched {
            res.append(movie)
        }
        return res
    }
    
    var watchlistedMovies: [SavedMovie] {
        var res = [SavedMovie]()
        for movie in movies where !movie.watched {
            res.append(movie)
        }
        return res
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: MovieListViewModel.fileKey) {
            let decoder = JSONDecoder()
            do {
                let decoded = try decoder.decode([SavedMovie].self, from: items)
                movies = decoded
                return
            } catch { print(error) }
        }
        movies = []
    }
    
    func addMovieToWatchlist(movieDetails movie: MovieDetails, moviePoster poster: Data) {
        let newMovie = SavedMovie(id: movie.id, title: movie.title, year: movie.releaseDate, poster: poster, watched: false, reviews: [])
        movies.append(newMovie)
    }

    func getMovieIndex(withID id: Int) -> Int? {
        return movies.firstIndex { $0.id == id }
    }
    
    func reviewMovie(movieDetails movie: MovieDetails, moviePoster poster: Data, movieReview review: Review) {
        print("movie pre count: ", movies.count)
        print(review)
        // TODO: rework this to be less jank
        let movieIndex = getMovieIndex(withID: movie.id)
        
        // movie is not in watchlist or reviewed list
        if movieIndex == nil {
            print(1)
            let newMovie = SavedMovie(id: movie.id, title: movie.title, year: movie.releaseDate, poster: poster, watched: true, reviews: [review])
            movies.append(newMovie)
            // movie already in reviewed
        } else if movies[movieIndex!].watched{
            print(2)
            movies[movieIndex!].reviews.append(review)
            
            // movie is in watchlist
        } else {
            print(3)
            movies[movieIndex!].watched = true
            movies[movieIndex!].reviews.append(review)
        }
        print("movie post count: ", movies.count)
    }
}
