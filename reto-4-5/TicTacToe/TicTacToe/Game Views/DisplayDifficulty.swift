//
//  DisplayDifficulty.swift
//  TicTacToe
//
//  Created by Antonio Torres-Ruiz on 6/21/21.
//

// This view displays the user's selected AI difficulty.

import SwiftUI

struct DisplayDifficulty: View {
    @ObservedObject var viewModel : GameViewModel
    var body: some View {
        Image("un-logo")
        
        Text("Tic Tac Toe DADM")
            .font(.system(size: 34, weight: .regular, design: .monospaced))
            .bold()
            .padding()
        
        Text(viewModel.difficulty + " Mode")
            //.font(.title)
            .padding() // Adds padding inside the background
            .background(
                Color.yellow // Sets the background color
                    .cornerRadius(5) // Optional: Rounds the corners of the background box
            )
            .foregroundColor(.black) // Sets the text color
    }
}
