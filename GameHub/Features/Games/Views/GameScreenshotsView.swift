//
//  GameScreenshotsView.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 14/9/23.
//

import SwiftUI

struct GameScreenshotsView: View {
    @Binding var screenshots: [ScreenshotsData]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(screenshots) { screenshot in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.clear)
                        .frame(width: 300, height: 200)
                        .background(
                            AsyncImage(url: URL(string: screenshot.image)) {image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .mask {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 300, height: 200)
                                    }
                            } placeholder: {
                                Image(systemName: "gamecontroller")
                                    .foregroundColor(.secondary)
                            }
                        )
                }
            }
        }
    }
}

struct GameScreenshotsView_Previews: PreviewProvider {
    static var previews: some View {
        GameScreenshotsView(screenshots: .constant([.test]))
    }
}
