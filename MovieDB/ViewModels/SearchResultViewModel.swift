//
//  SearchResultViewModel.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-20.
//

import Foundation

class SearchResultViewModel: ObservableObject {
    @Published var results: [Result]?
    
    init(searchQuery: String) {
        fetchResults(searchQuery: searchQuery)
    }
    
    func fetchResults(searchQuery: String) {
        // Generate Request
        let formatedSearchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&query=\(formatedSearchQuery)&page=1&include_adult=false"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            results = []
            return
        }
        let request = URLRequest(url: url)

        // Send Request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                // Process Responce
                if let decodedResponse = try? JSONDecoder().decode(SearchResponce.self, from: data) {
                    self.results = decodedResponse.results
                } else {
                    print("decode error")
                }
            } else {
                print("data error")
            }
        }.resume()
    }
}
