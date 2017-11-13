import UIKit

class Movement: NSObject {
    
    var batch : String
    var code : String
    var date : String
    
    init?(code: String, batch: String, date: String) {
        self.code = code
        self.batch = batch
        self.date = date
        
        super.init()
    }
    
    convenience init?(jsonData: [String: AnyObject]) {
        guard let dateValue = jsonData["date"] as? String,
            let batchValue = jsonData["batch"] as? Int64,
            let codeValue = jsonData["code"] as? Int64
            else {
                return nil
        }
        
        self.init(code: String(codeValue), batch: String(batchValue), date: dateValue)
    }
    
}

