import UIKit

class Egress: NSObject {
    
    var deliveryId : String
    var client : String
    var date : String
    
    init?(deliveryId: String, client: String, date: String) {
        self.deliveryId = deliveryId
        self.client = client
        self.date = date
        
        super.init()
    }
    
    convenience init?(jsonData: [String: AnyObject]) {
        guard let dateValue = jsonData["date"] as? String,
            let clientValue = jsonData["client"] as? String,
            let deliveryIdValue = jsonData["id"] as? Int64
            else {
                return nil
        }
        
        self.init(deliveryId: String(deliveryIdValue), client: clientValue, date: dateValue)
    }
    
}

