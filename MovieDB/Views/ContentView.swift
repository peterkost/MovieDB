//
//  ContentView.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-20.
//

import SwiftUI

struct ContentView: View {
    var movieListViewModel = MovieListViewModel()
    var body: some View {
        TabView {
            MovieListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
        .environmentObject(movieListViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
