

import SwiftUI

struct ContentView: View {
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible()),]
    @State private var moves:[Move?] = Array(repeating: nil,count: 9)
    @State private var isGameboardDisabled = false

    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                LazyVGrid(columns: columns,spacing: 0.5) {
                    ForEach(0..<9) { i in
                        ZStack {
                            Rectangle()
                                .foregroundColor(.purple).opacity(0.5)
                                .frame(width: geometry.size.width/3 - 15,
                                       height: geometry.size.width/3 - 15)
                            Image(systemName: moves[i]?.indicator ?? "")
                                .resizable()
                                .frame(width:40, height: 40)
                                .foregroundColor(.green)
                            
                        }
                        .onTapGesture{
                            if isSquareOccupied(in: moves, forIndex: i) { return }
                            moves[i] = Move(player:. human ,boardIndex: i)
                            isGameboardDisabled = true
                            
                            // check for win condition
                            
                            DispatchQueue.main.asyncAfter(deadline:.now() + 0.5) {
                                let computerPosition = determinecomputermovePosition(in: moves)
                                 moves[computerPosition] = Move(player:.computer ,boardIndex: computerPosition)
                                 isGameboardDisabled = false
                                
                            }
                           
                        }
                    }
                
                }
                Spacer()
                
            }
            .disabled(isGameboardDisabled)
            .padding()
            
        }
    }
    func  isSquareOccupied(in moves:[Move?] ,forIndex  index: Int) -> Bool{
        return moves.contains(where:{ $0?.boardIndex == index })
  }
    
    func determinecomputermovePosition(in moves: [Move?]) -> Int {
        var movesPosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movesPosition){
            movesPosition = Int.random(in: 0..<9)
        }
        return movesPosition
    }
    func checkWinCondition(for:Player,in moves:[Move?]) -> Bool{
        let winPatterns: Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],
         [0,4,8],[2,4,6]]
        return true
        
    }
}

enum Player {
    case human,computer
    
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "car":"bus"
     }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
