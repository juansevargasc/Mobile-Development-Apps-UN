import SwiftUI

struct DisplaySetup: View {
    @ObservedObject var viewModel: GameViewModel
    var geometry: GeometryProxy

    var body: some View {
        ScrollView([.vertical, .horizontal]) { // Allow both vertical and horizontal scrolling
            if geometry.size.width > geometry.size.height {
                // Landscape Layout
                HStack(alignment: .center, spacing: 20) {
                    // Sidebar with difficulty and scores
                    VStack(spacing: 20) {
                        DisplayDifficulty(viewModel: viewModel)
                        Scores(viewModel: viewModel)
                    }
                    .frame(width: geometry.size.width * 0.3) // Sidebar takes 30% of the width

                    // Tic Tac Toe Grid
                    GridView(viewModel: viewModel, geometry: geometry)
                        .frame(maxHeight: geometry.size.height * 0.8) // Ensure the grid fits nicely
                }
                .padding()
            } else {
                // Portrait Layout
                VStack(spacing: 20) {
                    // Display difficulty
                    DisplayDifficulty(viewModel: viewModel)

                    // Scores
                    Scores(viewModel: viewModel)

                    // Tic Tac Toe Grid
                    GridView(viewModel: viewModel, geometry: geometry)
                        .frame(maxHeight: geometry.size.height * 0.5) // Limit grid height

                    // Difficulty buttons
                    DifficultyChoices(viewModel: viewModel)
                }
                .padding()
            }
        }
        .disabled(viewModel.isGameboardDisabled) // Disable gameboard interactions if needed
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(
                title: alertItem.title,
                message: alertItem.message,
                dismissButton: .default(alertItem.buttonTitle) {
                    viewModel.resetGame()
                }
            )
        }
    }
}
