//
//  PopularMoviesViewModel.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-21.
//

import Foundation

class PopularMoviesViewModel: ObservableObject {
    @Published var popularMovies: [PopularMoviesResult]?
    
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
                    }
                } catch  {
                    print(error)
                }
            }
        }.resume()
    }
}
