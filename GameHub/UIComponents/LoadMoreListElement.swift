//
//  LoadMoreListElement.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 1/9/23.
//

import SwiftUI

struct LoadMoreListElement: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
    }
}

struct LoadMoreListElement_Previews: PreviewProvider {
    static var previews: some View {
        LoadMoreListElement()
    }
}
