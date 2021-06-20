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
                List {
                    if viewModel.results != nil {
                        ForEach(viewModel.results!) { result in
                            NavigationLink(destination: MovieDetailView(movieID: result.id)) {
                                Text("\(result.title) (\(String(result.releaseDate.prefix(4))))")
                                    .font(.headline)
                            }
                        }
                    }
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
