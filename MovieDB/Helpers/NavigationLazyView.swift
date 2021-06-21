//
//  NavigationLazyView.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-21.
//  From: https://stackoverflow.com/a/61234030/15880242
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
