import UIKit

class Entry: NSObject {
    
    var receptionId : String
    var provider : String
    var date : String
    
    init?(receptionId: String, provider: String, date: String) {
        self.receptionId = receptionId
        self.provider = provider
        self.date = date
        
        super.init()
    }
    
    convenience init?(jsonData: [String: AnyObject]) {
        guard let dateValue = jsonData["date"] as? String,
            let providerValue = jsonData["provider"] as? String,
            let receptionIdValue = jsonData["id"] as? Int64
            else {
                return nil
        }
        
        self.init(receptionId: String(receptionIdValue), provider: providerValue, date: dateValue)
    }
    
}

