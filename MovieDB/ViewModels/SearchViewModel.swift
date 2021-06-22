//
//  SearchViewModel.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-20.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var results = [Result]()
    @Published var searchQuery = "" {
        didSet {
            fetchResults()
        }
    }
    
    var showPopular: Bool {
        searchQuery == ""
    }
    
    func fetchResults() {
        let formatedSearchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&query=\(formatedSearchQuery)&page=1&include_adult=false"

        guard let url = URL(string: urlString) else {
            return
        }
        
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(SearchResponce.self, from: data) {
                    DispatchQueue.main.async {
                        self.results = decodedResponse.results
                    }
                }
            }
        }.resume()
    }
}
