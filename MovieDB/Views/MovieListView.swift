//
//  MovieListView.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-20.
//

import SwiftUI

struct MovieListView: View {
    @EnvironmentObject var movieList: MovieListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("pick list", selection: $movieList.listIndex) {
                    ForEach(0..<2) {
                        Text(movieList.lists[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // TODO: rework to less jank
                if movieList.listIndex == 0 {
                    WatchlistView()
                } else {
                    WatchedView()
                }
                
                Spacer()
            }
            .navigationBarTitle("MovieDB")
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
