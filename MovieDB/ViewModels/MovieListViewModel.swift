//
//  MovieListViewModel.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-21.
//

import Foundation

class MovieListViewModel: ObservableObject {
    static let fileKey = "SavedMovies"
    
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
        let newMovie = SavedMovie(id: movie.id, title: movie.title, year: movie.releaseDate, poster: poster, watched: false, review: [])
        movies.append(newMovie)
    }
}
