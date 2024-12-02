//
//  GridView.swift
//  TicTacToe
//
//  Created by Antonio Torres-Ruiz on 6/21/21.
//

// This view creates the board used for tictactoe, along with calling PlayerIndicator to determine which piece to place down for each player.

import SwiftUI

struct GridView: View {
    @ObservedObject var viewModel : GameViewModel
    var geometry : GeometryProxy
    var body: some View {
        LazyVGrid(columns: viewModel.columns, spacing: 5) {
            ForEach(0..<9) { i in
                ZStack {
                    BoardSquare(proxy: geometry)
                    
                    PlayerIndicator(systemImageName: viewModel.moves[i]?.indicator ?? "")
                }
                .onTapGesture {
                    viewModel.processPlayerMove(for: i)
                }
            }
        }
    }
}
