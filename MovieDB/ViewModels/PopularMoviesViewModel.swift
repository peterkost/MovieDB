//
//  PopularMoviesViewModel.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-21.
//

import Foundation

class PopularMoviesViewModel: ObservableObject {
    @Published var popularMovies: [PopularMoviesResult]?
    @Published var moviePosters =  [String:Data]()
    
    init() {
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1"

        guard let url = URL(string: urlString) else {
            popularMovies = []
            print("bad url")
            return
        }
        
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(PopularMoviesResponce.self, from: data)
                    DispatchQueue.main.async {
                        self.popularMovies = decodedResponse.results
                        self.loadPosters()
                    }
                } catch  {
                    print(error)
                }
            }
        }.resume()
    }
    
    func loadPosters() {
        for movie in popularMovies! {
            let urlString = "https://www.themoviedb.org/t/p/w1280\(movie.posterPath)"
            guard let url = URL(string: urlString) else { return }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.moviePosters[movie.originalTitle] = data
                }
            }
            task.resume()
        }
    }
}
