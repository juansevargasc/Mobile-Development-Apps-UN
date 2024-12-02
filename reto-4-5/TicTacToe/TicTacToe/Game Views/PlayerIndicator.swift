//
//  PlayerIndicator.swift
//  TicTacToe
//
//  Created by Antonio Torres-Ruiz on 6/18/21.
//

// This class tells GridView which image to place down on a square when it is selected in the grid.

import SwiftUI

struct PlayerIndicator: View {
    var systemImageName : String
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40, alignment: .center)
            .foregroundColor(.black)
    }
}
