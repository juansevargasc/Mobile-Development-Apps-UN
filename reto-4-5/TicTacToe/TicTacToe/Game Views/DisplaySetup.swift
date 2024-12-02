//
//  DisplaySetup.swift
//  TicTacToe
//
//  Created by Antonio Torres-Ruiz on 6/21/21.
//

// This view designs and displays everything related to the game. It calls for the DisplayDifficulty view to show the difficulty in text, the scores of both players, the grid itself and the buttons to choose difficulties.

import SwiftUI
struct DisplaySetup: View {
    @ObservedObject var viewModel : GameViewModel
    var geometry : GeometryProxy
    var body: some View {
        VStack {
            
            Spacer()
            
            // Display difficulty
            DisplayDifficulty(viewModel: viewModel)
            Spacer()
            
            
            // Player and Computer Scores
            //Scores(viewModel: viewModel)
            Spacer()
            
            // TicTacToe Grid
            GridView(viewModel: viewModel, geometry: geometry)
            Spacer()
            
            // Difficulty options
            DifficultyChoices(viewModel: viewModel)
            Spacer()
            Spacer()
        }
        .disabled(viewModel.isGameboardDisabled)
        .padding()
        .alert(item: $viewModel.alertItem, content: {alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: .default(alertItem.buttonTitle, action: {viewModel.resetGame()}))
        })
    }
}

