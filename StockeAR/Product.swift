import UIKit

class Product: NSObject {

    var productId : String
    var title : String
    var amount : Int64
    var batch : Int64
    var unit : String
    
    init?(productId: String, title: String, amount: Int64, batch: Int64, unit: String) {
        self.productId = productId
        self.title = title
        self.amount = amount
        self.batch = batch
        self.unit = unit
        
        super.init()
    }
    
}
