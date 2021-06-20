//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-20.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    @Published var movieDetails: MovieDetails?
    
    func fetchDetails(for id: Int) {
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
                        }
                } catch  {
                    print(error)
                }

            }
        }.resume()
    }
}
