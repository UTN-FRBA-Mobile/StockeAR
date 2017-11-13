import UIKit

class Egress: NSObject {
    
    var deliveryId : String
    var batch : String
    var date : String
    var code : String
    var from : String
    var amount : String
    
    init?(deliveryId: String, batch: String, date: String, code: String, from: String, amount: String) {
        self.deliveryId = deliveryId
        self.batch = batch
        self.date = date
        self.code = code
        self.from = from
        self.amount = amount
        
        super.init()
    }
    
    convenience init?(jsonData: [String: AnyObject]) {
        guard let dateValue = jsonData["date"] as? String,
            let batchValue = jsonData["batch"] as? Int64,
            let deliveryIdValue = jsonData["id"] as? Int64,
            let codeValue = jsonData["code"] as? Int64,
            let fromValue = jsonData["from"] as? String,
            let amountValue = jsonData["amount"] as? Int64
            else {
                return nil
        }
        
        self.init(deliveryId: String(deliveryIdValue), batch: String(batchValue), date: dateValue, code: String(codeValue), from: fromValue, amount: String(amountValue))
    }
    
}

