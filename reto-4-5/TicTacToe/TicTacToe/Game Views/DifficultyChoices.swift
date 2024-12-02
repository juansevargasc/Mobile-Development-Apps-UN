//
//  DifficultiesView.swift
//  TicTacToe
//
//  Created by Antonio Torres-Ruiz on 6/21/21.
//

// This view instantiates three buttons that let the user decide which difficulty of AI they want to play against.

import SwiftUI
import AudioToolbox
import UIKit


struct DifficultyChoices: View {
    @ObservedObject var viewModel : GameViewModel
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                AudioServicesPlaySystemSound(1104) // Play system tap sound
                    
                // Add haptic feedback
                let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
                impactFeedback.impactOccurred()
                
                //viewModel.alertItem = AlertContext.easyMode
                viewModel.difficulty = "Easy"
                viewModel.playerScore = 0
                viewModel.computerScore = 0
            }, label: {
                Text("Easy")
                    .foregroundColor(.black) // Text color
                    .font(.system(size: 20, weight: .bold, design: .default)) // Bold font style
                    .italic() // Italics for the text
                    .padding() // Adds spacing inside the button
                    .frame(maxWidth: .infinity) // Makes the button stretch horizontally
                    .background(Color.yellow) // Button background color
                    .cornerRadius(10) // Rounded corners
            })
            .padding()
            .shadow(color: .gray, radius: 5, x: 0, y: 5) // Adds shadow for depth

            Spacer()

            Button(action: {
                AudioServicesPlaySystemSound(1104) // Play system tap sound
                    
                // Add haptic feedback
                let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
                impactFeedback.impactOccurred()
                
                viewModel.alertItem = AlertContext.normalMode
                viewModel.difficulty = "Normal"
                viewModel.playerScore = 0
                viewModel.computerScore = 0
            }, label: {
                Text("Normal")
                    .foregroundColor(.black) // Text color
                    .font(.system(size: 14, weight: .bold, design: .default)) // Font size and weight
                    .italic() // Italicized text
                    .padding(.horizontal, 15) // Add horizontal padding to give the button enough space
                    .padding(.vertical, 10) // Add vertical padding
                    .background(Color.orange) // Button background color
                    .cornerRadius(10) // Rounded corners
            })
            .padding()
            .shadow(color: .gray, radius: 5, x: 0, y: 5) // Adds a shadow for depth


            Spacer()

            Button(action: {
                AudioServicesPlaySystemSound(1104) // Play system tap sound
                    
                // Add haptic feedback
                let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
                impactFeedback.impactOccurred()
                
                viewModel.alertItem = AlertContext.hardMode
                viewModel.difficulty = "Hard"
                viewModel.playerScore = 0
                viewModel.computerScore = 0
            }, label: {
                Text("Hard")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .italic()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            })
            .padding()
            .shadow(color: .gray, radius: 5, x: 0, y: 5)
            Spacer()

        }
    }
}

