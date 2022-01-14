import CoreGraphics


struct Message {
    
    var sender : String
    var body : String
    
    init(sender: String , body : String){
        self.sender = sender
        self.body = body
    }
    
}
