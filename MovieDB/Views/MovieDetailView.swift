//
//  MovieDetailView.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-20.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel: MovieDetailViewModel
    @EnvironmentObject var movieList: MovieListViewModel
    
    @State private var movieStatus: MovieStatus = .new
    
    init(movieID: Int) {
        viewModel = MovieDetailViewModel(for: movieID)
    }
    
    var body: some View {
        Group {
            if viewModel.movieDetails != nil && viewModel.moviePoster != nil {
                let movie = viewModel.movieDetails!
                Form {
                    Section(header: Text("details")) {
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
                    
                    Section(header: Text("save")) {
                        if movieStatus == .new {
                            Button("Add to Watchlist") {
                                movieList.addMovieToWatchlist(movieDetails: movie, moviePoster: viewModel.moviePoster!)
                                movieStatus = .watchlisted
                            }
                        }

                        Button("Review") {
                            viewModel.showingAddReview = true
                            // FIXME: you can open the review thing without actually saving a reivew
                            movieStatus = .watchlisted
                        }
                    }
                    
                    if movieStatus == .watched {
                        Section(header: Text("your review")) {
                            List {
                                ForEach(movieList.getMovieReviews(id: movie.id), id: \.self.date) { review in
                                    VStack {
                                        Text(review.title)
                                            .font(.title)
                                        Text(review.body)
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationBarTitle(movie.title)
                .sheet(isPresented: $viewModel.showingAddReview, content: {
                    MovieReviewView(movieDetails: movie, moviePoster: viewModel.moviePoster!)
                        .environmentObject(movieList)
                })
            } else {
                ProgressView()
            }
        }
        .onAppear(perform: { print("appeared"); movieStatus = movieList.getMovieStatus(id: viewModel.movieID) })
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movieID: 14609)
    }
}
