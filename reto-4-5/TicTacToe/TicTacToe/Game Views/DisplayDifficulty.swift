//
//  DisplayDifficulty.swift
//  TicTacToe
//
//  Created by Antonio Torres-Ruiz on 6/21/21.
//

// This view displays the user's selected AI difficulty.

import SwiftUI

struct DisplayDifficulty: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack(spacing: 20) { // Align items vertically with spacing
            // Display Logo
            Image("un-logo")
                .resizable()
                .scaledToFit()
                .frame(height: 80) // Adjust height of the logo
                .padding(.top)

            // Display Title
            Text("Tic Tac Toe DADM")
                .font(.system(size: 34, weight: .regular, design: .monospaced))
                .bold()
                .multilineTextAlignment(.center) // Center align text
                .padding()

            // Display Difficulty
            Text(viewModel.difficulty + " Mode")
                .font(.title2)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(
                    Color.yellow
                        .cornerRadius(8) // Rounded background
                )
                .foregroundColor(.black) // Text color
        }
        .frame(maxWidth: .infinity) // Make the view stretch horizontally
        .padding()
    }
}

struct DisplayDifficulty_Previews: PreviewProvider {
    static var previews: some View {
        // Portrait Mode Preview
        DisplayDifficulty(viewModel: GameViewModel())
            .previewLayout(.fixed(width: 375, height: 812)) // iPhone in portrait mode
            .previewDisplayName("Portrait Mode")

        // Landscape Mode Preview
        DisplayDifficulty(viewModel: GameViewModel())
            .previewLayout(.fixed(width: 812, height: 375)) // iPhone in landscape mode
            .previewDisplayName("Landscape Mode")
    }
}
