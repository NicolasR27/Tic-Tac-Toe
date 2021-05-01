
import SwiftUI

struct AlertItem: Identifiable{
    let id = UUID()
    var title:Text
    var message:Text
    var buttonTitle:Text
}

struct AlertContext {
   static let humanWin  = AlertItem(title: Text("you win"),
                      message: Text("you are so smart"),
                      buttonTitle: Text("hell yeah"))
    
    
    static let computuerWin = AlertItem(title: Text("you lost"),
                      message: Text("you programmed super ai"),
                      buttonTitle: Text("rematch"))
    
    static let draw =  AlertItem(title: Text("draw"),
                      message: Text("you are so smart"),
                      buttonTitle: Text("try again"))
    
    
    
}
