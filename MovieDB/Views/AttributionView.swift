//
//  AttributionView.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-22.
//

import SwiftUI

struct AttributionView: View {
    var body: some View {
        VStack {
            Image("tmdb")
            Text("This product uses the TMDb API but is not endorsed or certified by TMDb.")
                .font(.footnote)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
    }
}

struct AttributionView_Previews: PreviewProvider {
    static var previews: some View {
        AttributionView()
    }
}
