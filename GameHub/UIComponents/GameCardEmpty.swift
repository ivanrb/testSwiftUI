//
//  GameCardEmpty.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 30/8/23.
//

import SwiftUI

struct GameCardEmpty: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "gamecontroller")
                .symbolVariant(.fill)
                .foregroundColor(.secondary)
            Text("Empty")
            Spacer()
        }
    }
}

struct GameCardEmpty_Previews: PreviewProvider {
    static var previews: some View {
        GameCardEmpty()
    }
}
