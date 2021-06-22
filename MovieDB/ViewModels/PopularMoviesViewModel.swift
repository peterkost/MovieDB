//
//  PopularMoviesViewModel.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-21.
//

import Foundation

class PopularMoviesViewModel: ObservableObject {
    struct PopularMovie: Identifiable {
        let title: String
        let id: Int
        let poster: Data
    }
    @Published var movies = [PopularMovie]()
    @Published var requestResult = [PopularMoviesResult]()
    
    init() {
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1"

        guard let url = URL(string: urlString) else {
            requestResult = []
            print("bad url")
            return
        }
        
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(PopularMoviesResponce.self, from: data)
                    DispatchQueue.main.async {
                        self.requestResult = decodedResponse.results
                        self.loadPosters()
                    }
                } catch  {
                    print(error)
                }
            }
        }.resume()
    }
    
    func loadPosters() {
        for movie in requestResult {
            let urlString = "https://www.themoviedb.org/t/p/w1280\(movie.posterPath)"
            guard let url = URL(string: urlString) else { return }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    print("Loaded \(movie.title)")
                    self.movies.append(PopularMovie(title: movie.title, id: movie.id, poster: data))
                }
            }
            task.resume()
        }
    }
}
