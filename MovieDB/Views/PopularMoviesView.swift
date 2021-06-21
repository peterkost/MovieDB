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
                    ForEach(viewModel.popularMoviesFinal) { movie in
                        NavigationLink(destination: NavigationLazyView(MovieDetailView(movieID: movie.id))) {
                            VStack {
                                Image(uiImage: UIImage(data: movie.poster) ?? UIImage())
                                    .resizable()
                                    .scaledToFit()
                                Text(movie.title)
                                    .font(.subheadline)
                            }
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
