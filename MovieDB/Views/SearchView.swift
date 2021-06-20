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
            HStack {
                TextField("Search movie name", text: $viewModel.searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                NavigationLink(destination: SearchResultView(viewModel: SearchResultViewModel(searchQuery: viewModel.searchQuery))) {
                    Image(systemName: "magnifyingglass")
                }
            }
            .padding()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
