//
//  ContentView.swift
//  TicTacToe
//
//  Created by Antonio Torres-Ruiz on 6/17/21.
//

// Inspired by: Sean Allen's Tic Tac Toe tutorial on YouTube
// Source to original video and code: https://youtu.be/MCLiPW2ns2w

// This is the main view for the game, which just calls all the other subsequent views of the game.

import SwiftUI

struct MainView: View {
    var body: some View {
        GeometryReader { geometry in
            GameView(geometry: geometry)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
