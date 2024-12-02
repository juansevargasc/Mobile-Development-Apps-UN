//
//  ScoreView.swift
//  TicTacToe
//
//  Created by Antonio Torres-Ruiz on 6/21/21.
//

// This view displays the Player and the Computer's scores for their current game and difficulty.

import SwiftUI

struct Scores: View {
    @ObservedObject var viewModel : GameViewModel
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("Player's Score")
                    .font(.headline)
                    .padding(.bottom, 10)
                    .foregroundColor(.black)
                Text(String(viewModel.playerScore))
                    .font(.largeTitle)
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            VStack {
                Text("Computer's Score")
                    .font(.headline)
                    .padding(.bottom, 10)
                    .foregroundColor(.black)
                Text(String(viewModel.computerScore))
                    .font(.largeTitle)
                    .foregroundColor(.black)
            }
            Spacer()
        }
    }
}
