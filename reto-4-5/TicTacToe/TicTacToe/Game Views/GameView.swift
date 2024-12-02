//
//  TicTacToeView.swift
//  TicTacToe
//
//

// This view instantiates an instance of the view model, geometry of the screen, and the background which are then passed to DisplaySetup to continue drawing the game screen

import SwiftUI

struct GameView: View {
    // create an instance of the view model
    @ObservedObject private var viewModel = GameViewModel()
    var geometry : GeometryProxy
    var body: some View {
        ZStack {
            // background image
            Image("green-board")
            .resizable()
            .scaledToFill() // Ensures the image fills the available space
            .frame(width: geometry.size.width, height: geometry.size.height * 1.1)
            .clipped() // Ensures no overflow beyond bounds
            //Image("paper")
                .ignoresSafeArea()
            DisplaySetup(viewModel: viewModel, geometry: geometry)
        }
    }
}
