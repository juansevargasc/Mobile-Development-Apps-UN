//
//  GridView.swift
//  TicTacToe
//
//  Created by Antonio Torres-Ruiz on 6/21/21.
//

// This view creates the board used for tictactoe, along with calling PlayerIndicator to determine which piece to place down for each player.

import SwiftUI
import AudioToolbox
import UIKit

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
                    // Play tap sound
                    AudioServicesPlaySystemSound(1105) // System "tap" sound
                    
                    // Add haptic feedback for better interaction
                    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
                    impactFeedback.impactOccurred()
                    
                    // Process the move
                    viewModel.processPlayerMove(for: i)
                }
            }
        }
    }
}
