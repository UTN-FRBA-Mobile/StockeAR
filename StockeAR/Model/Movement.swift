import UIKit

class Movement: NSObject {
    
    var batch : String
    var code : String
    var date : String
    var amount : String
    var from : String
    var to : String
    
    init?(code: String, batch: String, date: String, from: String, to: String, amount: String) {
        self.code = code
        self.batch = batch
        self.date = date
        self.from = from
        self.to = to
        self.amount = amount
        
        super.init()
    }
    
    convenience init?(jsonData: [String: AnyObject]) {
        guard let dateValue = jsonData["date"] as? String,
            let batchValue = jsonData["batch"] as? Int64,
            let fromValue = jsonData["from"] as? String,
            let toValue = jsonData["to"] as? String,
            let amountValue = jsonData["amount"] as? Int64,
            let codeValue = jsonData["code"] as? Int64
            else {
                return nil
        }
        
        self.init(code: String(codeValue), batch: String(batchValue), date: dateValue, from: fromValue, to: toValue, amount: String(amountValue))
    }
    
}

