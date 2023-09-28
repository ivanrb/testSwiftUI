//
//  GameDetailView.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 12/9/23.
//

import SwiftUI

struct GameDetailView: View {
    @EnvironmentObject var viewModel: GamesViewModel
    @Environment(\.dismiss) var dismiss
    
    var gameId: Int
    
    @State private var image: UIImage?
    @State private var screenshots: [ScreenshotsData] = []
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                Rectangle()
                    .fill(.clear)
                    .frame(height: 220)
                    .background {
                        if let image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 220)
                                .mask {
                                    Rectangle()
                                        .frame(height: 220)
                                }
                            
                        } else {
                            Image(systemName: "gamecontroller")
                        }
                    }
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .symbolVariant(.circle)
                        .symbolVariant(.fill)
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                }
                .padding(30)
            }
            ScrollView(showsIndicators: false) {
                if let game = viewModel.gameDetail {
                    Text(game.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    GameScreenshotsView(screenshots: $screenshots)
                    Text(game.descriptionRaw)
                        .foregroundColor(.white)
                        .frame(alignment: .leading)
                }
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
        .background(Color(viewModel.getGamePredominatColor()))
        .edgesIgnoringSafeArea(.vertical)
        .onAppear {
            Task(priority: .high) {
                await viewModel.fetchGameDetail(for: gameId)
                if let gameDetail = viewModel.gameDetail {
                    let image = Network.shared.getImage(name: gameDetail.backgroundImage)
                    self.image = image
                    self.screenshots = await viewModel.getGameScreenshots()
                }
            }
        }
    }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(gameId: GameData.test1.id)
            .environmentObject(GamesViewModel.test)
    }
}
