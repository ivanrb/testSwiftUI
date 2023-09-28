//
//  GameCardView.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 29/8/23.
//

import SwiftUI

struct GameCardView: View {
    let game: GameData
    let isGridView: Bool
    
    init(game: GameData, isGridView: Bool = false) {
        self.game = game
        self.isGridView = isGridView
    }
    
    @State private var image: UIImage?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if let image {
                Rectangle()
                    .fill(.clear)
                    .frame(height: 175)
                    .background(
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                    )
                    .mask {
                        RoundedRectangle(cornerRadius: 8)
                    }
            } else {
                Rectangle()
                    .fill(.clear)
                    .frame(height: 175)
                    .background(Color(white: 0.9))
                    .mask {
                        RoundedRectangle(cornerRadius: 8)
                    }
            }
            Rectangle()
                .opacity(0.4)
                .frame(height: 50)
                .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
                .overlay(alignment: .leading) {
                    Text(game.name)
                        .foregroundColor(.primary)
                        .colorInvert()
                        .font(isGridView ? .headline : .title)
                        .lineLimit(isGridView ? 2 : 1)
                        .padding(.horizontal, 8)
                }
        }
        .onAppear {
            Network.shared.getImage(of: game) { image in
                self.image = image
            }
        }
    }
}

struct GameCard_Previews: PreviewProvider {
    static var previews: some View {
        GameCardView(game: .test1)
    }
}
