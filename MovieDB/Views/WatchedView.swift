//
//  WatchedView.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-21.
//

import SwiftUI

struct WatchedView: View {
    @EnvironmentObject var movieList: MovieListViewModel
    
    var body: some View {
        List {
            ForEach(movieList.watchedMovies) { movie in
                NavigationLink(destination: NavigationLazyView(MovieDetailView(movieID: movie.id))) {
                HStack {
                    Image(uiImage: UIImage(data: movie.poster) ?? UIImage())
                        .resizable()
                        .frame(width: posterHeight * posterAspectRatio, height: posterHeight)
                        .scaledToFit()
                    
                    VStack(alignment: .leading) {
                        Text("\(movie.title) (\(String(movie.year.prefix(4))))")
                            .font(.headline)
                        Text("Reviewed on: \(movie.reviews.last!.shortDate)")
                        Text("Rating: \(movie.reviews.last!.score)")
                    }
                }
            }
            }
        }
    }
    
    let posterHeight: CGFloat = 125
    let posterAspectRatio: CGFloat = 0.690
}

struct WatchedView_Previews: PreviewProvider {
    static var previews: some View {
        WatchedView()
    }
}
