//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Antonio Torres-Ruiz on 6/17/21.
//

// The view model for this game, handling all of the business logic and default states of the game.

import SwiftUI
import AudioToolbox // Add this to play system sounds


final class GameViewModel: ObservableObject {
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameboardDisabled = false
    @Published var alertItem: AlertItem?
    @Published var playerScore: Int = 0
    @Published var computerScore: Int = 0
    @Published var difficulty : String = "Easy"
    
    func processPlayerMove(for position: Int) {
        if isSquareOccupied(in: moves, forIndex: position) { return }
        moves[position] = Move(player: .human, boardIndex: position)
        
        // check for win condition or draw
        if checkWinCondition(for: .human, in: moves) {
            playWinningSound() // Play special sound for win
            alertItem = AlertContext.humanWin
            return
        }
        
        if checkForDraw(in: moves) {
            alertItem = AlertContext.draw
            return
        }
        
        isGameboardDisabled = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            let compPos = determineComputerMovePosition(in: moves)
            moves[compPos] = Move(player: .computer, boardIndex: compPos)
            isGameboardDisabled = false
                
            if checkWinCondition(for: .computer, in: moves) {
                alertItem = AlertContext.compWin
                return
            }
                
            if checkForDraw(in: moves) {
                alertItem = AlertContext.draw
                return
            }
        }
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: {$0?.boardIndex == index})
    }
    
    // Easy mode: AI just chooses random squares until it wins
    // Normal: AI goes for winning moves and choosing random squares
    // Hard: AI goes for winning moves, blocking the player, taking the middle square, then choosing random squares
    
    // If AI can win, then win
    // If AI can't win, then block
    // If AI can't block, take middle square
    // If AI can't take middle square, pick a random square
    func determineComputerMovePosition(in moves: [Move?]) -> Int {
        // If AI can win, then win
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let compMoves = moves.compactMap{$0}.filter{$0.player == .computer }
        let compPos = Set(compMoves.map{$0.boardIndex})
        
        // AI goes for winning moves on Normal and Hard mode
        if (difficulty == "Normal" || difficulty == "Hard") {
            for pattern in winPatterns {
                let winPositions = pattern.subtracting(compPos)
                
                if winPositions.count == 1 {
                    let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                    if isAvailable { return winPositions.first! }
                }
            }
        }
        
        // AI tries to block the player and goes for the middle square on Hard mode
        if (difficulty == "Hard") {
            // If AI can't win, then block
            let humanMoves = moves.compactMap{$0}.filter{$0.player == .human }
            let humanPos = Set(humanMoves.map{$0.boardIndex})
            
            for pattern in winPatterns {
                let winPositions = pattern.subtracting(humanPos)
                
                if winPositions.count == 1 {
                    let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                    if isAvailable { return winPositions.first! }
                }
            }
        
            // If AI can't block, then take middle square
            let centerSquare = 4
            if !isSquareOccupied(in: moves, forIndex: centerSquare) {
                return centerSquare
            }
        }
        
        // AI does this on every difficulty. If AI can't take middle square, then take random available square
        var movePos = Int.random(in: 0..<9)
        while isSquareOccupied(in: moves, forIndex: movePos) {
            movePos = Int.random(in: 0..<9)
        }
        return movePos
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let playerMoves = moves.compactMap{ $0 }.filter{$0.player == player}
        let playerPos = Set(playerMoves.map{$0.boardIndex})
        
        for pattern in winPatterns where pattern.isSubset(of: playerPos) {
            if (player == .human) {
                playerScore += 1
            } else if (player == .computer) {
                computerScore += 1
            }

            return true
            
        }
        
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap{$0}.count == 9
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
    
    private func playWinningSound() {
        // Play a unique system sound for winning
        AudioServicesPlaySystemSound(1013) // 1013: Long tone
        
        // Optional: Add haptic feedback for extra effect
        let successFeedback = UINotificationFeedbackGenerator()
        successFeedback.notificationOccurred(.success)
    }
    
    
}
