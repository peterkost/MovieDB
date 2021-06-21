//
//  MovieDetailView.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-20.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel: MovieDetailViewModel
    
    init(movieID: Int) {
        print("ran MovieDetailView init")
        viewModel = MovieDetailViewModel(for: movieID)
    }
    
    var body: some View {
        Group {
            if viewModel.movieDetails != nil && viewModel.moviePoster != nil {
                let movie = viewModel.movieDetails!
                List {
                    Image(uiImage: UIImage(data: viewModel.moviePoster!) ?? UIImage())
                        .resizable()
                        .scaledToFit()
                    
                    Text(movie.releaseDate)
                
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(movie.genres) {
                                Text($0.name)
                            }
                        }
                    }
                }
                .navigationBarTitle(movie.title)
            } else {
                ProgressView()
            }
        }
        
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movieID: 14609)
    }
}
