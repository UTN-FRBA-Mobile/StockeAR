import UIKit

class Entry: NSObject {
    
    var receptionId : String
    var code : String
    var date : String
    var amount : String
    var batch : String
    var location : String
    
    init?(receptionId: String, code: String, date: String, amount: String, batch: String, location: String) {
        self.receptionId = receptionId
        self.code = code
        self.date = date
        self.amount = amount
        self.batch = batch
        self.location = location
        
        super.init()
    }
    
    convenience init?(jsonData: [String: AnyObject]) {
        guard let dateValue = jsonData["date"] as? String,
            let codeValue = jsonData["code"] as? Int64,
            let receptionIdValue = jsonData["id"] as? Int64,
            let amountValue = jsonData["amount"] as? Int64,
            let batchValue = jsonData["batch"] as? Int64,
            let locationValue = jsonData["location"] as? String
            else {
                return nil
        }
        
        self.init(receptionId: String(receptionIdValue), code: String(codeValue), date: dateValue, amount: String(amountValue), batch: String(batchValue), location: locationValue)
    }
    
}

