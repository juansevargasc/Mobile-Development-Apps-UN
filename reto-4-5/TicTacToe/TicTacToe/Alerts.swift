//
//  Alerts.swift
//  TicTacToe
//
//  Created by Antonio Torres-Ruiz on 6/17/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title : Text
    var message : Text
    var buttonTitle : Text
}

struct AlertContext {
    static let humanWin = AlertItem(title: Text("You Win!"), message: Text("You won the game! Want to play again?"), buttonTitle: Text("Play Again."))
    static let compWin = AlertItem(title: Text("You Lost..."), message: Text("The AI beat you. Want to try again?"), buttonTitle: Text("Rematch."))
    static let draw = AlertItem(title: Text("Draw."), message: Text("Looks like no one won. Try again?"), buttonTitle: Text("Rematch."))
    static let easyMode = AlertItem(title: Text("Easy Mode."), message: Text("The computer player will pick random squares.."), buttonTitle: Text("Begin."))
    static let normalMode = AlertItem(title: Text("Normal Mode."), message: Text("The computer player will pick random squares and go for winning moves."), buttonTitle: Text("Begin."))
    static let hardMode = AlertItem(title: Text("Hard Mode."), message: Text("The computer player will go for winning moves, block you, take the middle square if available, and then pick random squares. Good luck."), buttonTitle: Text("Begin."))
}
