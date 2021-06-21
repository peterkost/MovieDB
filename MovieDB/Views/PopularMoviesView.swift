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
                    ForEach(Array(viewModel.moviePosters.keys), id: \.self) { i in
                        VStack {
                            Image(uiImage: UIImage(data: viewModel.moviePosters[i]!) ?? UIImage())
                                .resizable()
                                .scaledToFit()
                            Text(i)
                                .font(.subheadline)
                        }
//                        NavigationLink(destination: NavigationLazyView(MovieDetailView(movieID: viewModel.popularMovies![i].id))) {
//                            VStack {
//

//                            }
//                        }
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
