//
//  GameModel.swift
//  TicTacToe
//
//  Created by Antonio Torres-Ruiz on 6/17/21.
//

// This game uses a simple Model of a Player enum and Move struct for handling the logic of the players and their moves.

import SwiftUI

enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex : Int

    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}
