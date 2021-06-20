//
//  SearchResultView.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-20.
//

import SwiftUI

struct SearchResultView: View {
    @ObservedObject var viewModel: SearchResultViewModel
    
    var body: some View {
        List {
            if viewModel.results != nil {
                ForEach(viewModel.results!) { result in
                    Text(result.title)
                }
            } else {
                Text("No Results")
            }
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(viewModel: SearchResultViewModel(searchQuery: "Drive"))
    }
}
