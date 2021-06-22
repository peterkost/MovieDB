//
//  SearchView.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-20.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("enter movie name", text: $viewModel.searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button(action: viewModel.fetchResults) {
                        
                        Image(systemName: "magnifyingglass")
                    }
                    .padding()
                }
//                if viewModel.results != nil {
                if !viewModel.showPopular {
                    List {
                        ForEach(viewModel.results) { result in
                            // NavigationLazyView prevents the MovieDetailView init from being run for every search result
                            NavigationLink(destination: NavigationLazyView(MovieDetailView(movieID: result.id))) {
                                Text("\(result.title) (\(String(result.releaseDate.prefix(4))))")
                                    .font(.headline)
                            }
                        }
                        AttributionView()
                    }
                } else {
                    PopularMoviesView()
                }
            }
            .navigationBarTitle("Search")
        }

    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
