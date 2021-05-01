
import SwiftUI

struct AlertItem: Identifiable{
    let id = UUID()
    var title:Text
    var message:Text
    var buttonTitle:Text
}

struct AlertContext {
   static let humanWin  = AlertItem(tite: Text("you win"),
                      message: Text("you are so smart"),
                      buttonTitle: Text("hell yeah"))
    
    
    static let computuerWin = AlertItem(tite: Text("you lost"),
                      message: Text("you programmed super ai"),
                      buttonTitle: Text("rematch"))
    
    static let draw =  AlertItem(tite: Text("draw"),
                      message: Text("you are so smart"),
                      buttonTitle: Text("try again"))
    
    
    
}
