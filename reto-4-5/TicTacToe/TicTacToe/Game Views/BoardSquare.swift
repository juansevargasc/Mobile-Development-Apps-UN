//
//  GameBoardView.swift
//  TicTacToe
//
//  Created by Antonio Torres-Ruiz on 6/18/21.
//

// This view creates each board used in the LazyVGrid used to create the TicTacToe grid.

import SwiftUI
struct BoardSquare: View {
    var proxy : GeometryProxy
    var body: some View {
        Rectangle()
            .foregroundColor(.clear).opacity(0.5)
            .frame(width: proxy.size.width/3 - 15, height: proxy.size.width/3 - 15)
            .cornerRadius(15.0)
            .border(Color.black, width: 1)
    }
}
