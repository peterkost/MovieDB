//
//  MovieListViewModel.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-21.
//

import Foundation

class MovieListViewModel: ObservableObject {
    // MARK: Used by multiple views as environment object
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
    
    var watchedMovies: [SavedMovie] {
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
        // TODO: rework this to be less jank
        let movieIndex = getMovieIndex(withID: movie.id)
        
        // movie is not in watchlist or reviewed list
        if movieIndex == nil {
            let newMovie = SavedMovie(id: movie.id, title: movie.title, year: movie.releaseDate, poster: poster, watched: true, reviews: [review])
            movies.append(newMovie)
            // movie already in reviewed
        } else if movies[movieIndex!].watched{
            movies[movieIndex!].reviews.append(review)
            
            // movie is in watchlist
        } else {
            movies[movieIndex!].watched = true
            movies[movieIndex!].reviews.append(review)
        }
    }
    // TODO: refactor this into seperate classes
    
    // MARK: Only used in actual MovieListView
    @Published var listIndex = 0
    
    let lists = ["Watchlist", "Watched"]
    
    func removeFromWatchlist(at offset: IndexSet) {
        let index = offset[offset.startIndex]
        let target = watchlistedMovies[index]
        if let movieIndex = getMovieIndex(withID: target.id) {
            movies.remove(at: movieIndex)
        }
    }
    
    func removeFromWatched(at offset: IndexSet) {
        let index = offset[offset.startIndex]
        let target = watchedMovies[index]
        if let movieIndex = getMovieIndex(withID: target.id) {
            movies.remove(at: movieIndex)
        }
    }
    
    // MARK: Only used in actual MovieDetailsView
    func getMovieStatus(id: Int) -> MovieStatus {
        let movieIndex = getMovieIndex(withID: id)
        if movieIndex == nil {
            return .new
        } else if movies[movieIndex!].watched{
            return .watched
        } else {
            return .watchlisted
        }
    }
    
    func getMovieReviews(id: Int) -> [Review] {
        watchedMovies.first { $0.id == id }!.reviews
    }
}

enum MovieStatus {
    case watched, watchlisted, new
}
