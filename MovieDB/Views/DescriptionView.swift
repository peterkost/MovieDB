//
//  DescriptionView.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-22.
//

import SwiftUI

struct DescriptionView: View {
    let text: String
    
    var body: some View {
        VStack {
            Text(text)
            Spacer()
        }
        .padding()
        .navigationBarTitle("Overview")
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView(text: "xd")
    }
}
