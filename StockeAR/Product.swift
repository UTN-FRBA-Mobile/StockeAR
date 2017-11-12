import UIKit

class Product: NSObject {

    var productId : String
    var amount : String
    var batch : String
    var unit : String
    var location : String
    var expirationDate : String
    
    init?(productId: String, amount: String, batch: String, unit: String, location: String, expirationDate: String) {
        self.productId = productId
        self.amount = amount
        self.batch = batch
        self.unit = unit
        self.location = location
        self.expirationDate = expirationDate
        
        super.init()
    }
    
    convenience init?(jsonData: [String: AnyObject]) {
        guard let productIdValue = jsonData["id"] as? Int64,
        let amountValue = jsonData["amount"] as? Int64,
        let batchValue = jsonData["batch"] as? Int64,
        let unitValue = jsonData["unit"] as? String,
        let expirationDateValue = jsonData["expiration_date"] as? String,
        let locationValue = jsonData["location"] as? String
        else {
            return nil
        }
        
        self.init(productId: String(productIdValue), amount: String(amountValue), batch: String(batchValue), unit: String(unitValue), location: locationValue, expirationDate: expirationDateValue)
    }
    
}
