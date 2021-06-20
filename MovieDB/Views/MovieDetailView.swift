//
//  MovieDetailView.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-20.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel = MovieDetailViewModel()
    let movieID: Int
    
    var body: some View {
        Group {
            if viewModel.movieDetails != nil {
                let movie = viewModel.movieDetails!
                List {
                    Image(uiImage: UIImage(data: viewModel.moviePoster ?? Data()) ?? UIImage())
                        .resizable()
                        .scaledToFit()
                    
                    Text(movie.releaseDate)
                
                    HStack {
                        ForEach(movie.genres) {
                            Text($0.name)
                        }
                    }
                }
                .navigationBarTitle(movie.title)
            } else {
                ProgressView()
            }
        }
        .onAppear(perform: {
            viewModel.fetchDetails(for: movieID)
        })
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movieID: 14609)
    }
}
