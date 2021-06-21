//
//  PopularMoviesView.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-21.
//

import SwiftUI

struct PopularMoviesView: View {
    @ObservedObject var viewModel = PopularMoviesViewModel()
    
    var body: some View {
        VStack {
            if viewModel.popularMovies != nil {
                List {
                    ForEach(viewModel.popularMovies!) { movie in
                        NavigationLink(destination: NavigationLazyView(MovieDetailView(movieID: movie.id))) {
                            Text(movie.originalTitle)
                                .font(.headline)
                        }
                    }
                }
            } else {
                ProgressView()
            }
            Spacer()
        }
    }
}

struct PopularMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        PopularMoviesView()
    }
}
