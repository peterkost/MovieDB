//
//  WatchlistView.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-21.
//

import SwiftUI

struct WatchlistView: View {
    @EnvironmentObject var movieList: MovieListViewModel
    
    var body: some View {
        List {
            ForEach(movieList.watchlistedMovies) { movie in
                NavigationLink(destination: NavigationLazyView(MovieDetailView(movieID: movie.id))) {
                HStack {
                    Image(uiImage: UIImage(data: movie.poster) ?? UIImage())
                        .resizable()
                        .frame(width: posterHeight * posterAspectRatio, height: posterHeight)
                        .scaledToFit()
                    
                    VStack {
                        Text("\(movie.title) (\(String(movie.year.prefix(4))))")
                            .font(.headline)
                    }
                }
                }
            }
        }
    }
    
    let posterHeight: CGFloat = 125
    let posterAspectRatio: CGFloat = 0.690
}

struct WatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistView()
    }
}
