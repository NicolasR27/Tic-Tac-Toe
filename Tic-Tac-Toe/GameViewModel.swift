

import SwiftUI

final class GameViewModel:ObservableObject{
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible()),]
    
    
    @Published var moves:[Move?] = Array(repeating: nil,count: 9)
    @Published var isGameboardDisabled = false
    @Published var alertItem : AlertItem?
    
    
    func processPlayerMove(for position: Int ) {
        if isSquareOccupied(in: moves, forIndex: position) { return }
        moves[position] = Move(player:. human ,boardIndex: position)
        
        if checkWinCondition(for: .human, in: moves){
            print("Human Wins")
            alertItem = AlertContext.humanWin
            return
        }
        if checkForDraw(in: moves) {
            print("draw")
            alertItem = AlertContext.draw
            return
        }
        isGameboardDisabled = true
        
        DispatchQueue.main.asyncAfter(deadline:.now() + 0.5) {[self] in
            let computerPosition = determinecomputermovePosition(in: moves)
            moves[computerPosition] = Move(player:.computer ,boardIndex: computerPosition)
            isGameboardDisabled = false
            if checkWinCondition(for: .computer, in: moves){
                print("computer Wins")
                alertItem = AlertContext.computuerWin
                return
            }
            
            if checkForDraw(in: moves){
                alertItem = AlertContext.draw
                print("draw")
                return
            }
            
        }
    }
    
    
    
    func isSquareOccupied(in moves:[Move?] ,forIndex  index: Int) -> Bool{
        return moves.contains(where:{ $0?.boardIndex == index })
    }
    
    func determinecomputermovePosition(in moves: [Move?]) -> Int {
        let winPatterns: Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],
                                          [0,4,8],[2,4,6]]
        let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
        let computerPositions = Set(computerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns{
            let winPositions = pattern.subtracting(computerPositions)
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable { return winPositions.first!}
                
                
            }
            
        }
        
        let HumanMoves = moves.compactMap { $0 }.filter { $0.player == .human }
        let HumanPositions = Set(HumanMoves.map { $0.boardIndex })
        
        for pattern in winPatterns{
            let winPositions = pattern.subtracting(HumanPositions)
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable { return winPositions.first!}
                
                
            }
        }
        
        if isSquareOccupied(in: moves, forIndex: 4){
            let centerSqaure = 4
            if !isSquareOccupied(in: moves, forIndex: centerSqaure){
                return centerSqaure
                
            }
            
            
        }
        
        
        
        var movesPosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movesPosition){
            movesPosition = Int.random(in: 0..<9)
        }
        return movesPosition
    }
    func checkWinCondition(for player:Player,in moves:[Move?]) -> Bool{
        let winPatterns: Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],
                                          [0,4,8],[2,4,6]]
        
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true}
        return false
        
    }
    
    func checkForDraw(in moves:[Move?]) -> Bool {
        return moves.compactMap{$0}.count == 9
    }
    func resetGame(){
        moves = Array(repeating: nil,count: 9)
    }
}




