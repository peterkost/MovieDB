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
        List {
            ForEach(movieList.movies) { movie in
                Button(movie.title) {
                    print(movie.reviews)
                }
                
            }
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
