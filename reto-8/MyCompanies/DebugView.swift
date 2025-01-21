//
//  DebugView.swift
//  MyBooks
//
//  Created by Juanse Vargas on 1/20/25.
//

import SwiftUI

struct DebugView: View {
    var body: some View {
        VStack {
            Button("Copy Database to Documents") {
                copyDatabaseToDocuments()
            }
            .padding()
            .buttonStyle(.borderedProminent)
            Text("Press the button to copy the database file to the Documents directory.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}
