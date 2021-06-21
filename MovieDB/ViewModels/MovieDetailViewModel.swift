//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-20.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    @Published var movieDetails: MovieDetails?
    @Published var moviePoster: Data?
    
    @Published var showingAddReview = false
    
     init(for id: Int) {
        // Fetch details
        let urlString = "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=en-US"

        guard let url = URL(string: urlString) else {
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(MovieDetails.self, from: data)
                        DispatchQueue.main.async {
                            self.movieDetails = decodedResponse
                            self.loadPoster(id: decodedResponse.posterPath)
                        }
                } catch  {
                    print(error)
                }

            }
        }.resume()
    }
    
    func loadPoster(id posterID: String) {
        let urlString = "https://www.themoviedb.org/t/p/w1280\(posterID)"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.moviePoster = data
            }
        }
        task.resume()
    }
}
