import UIKit
import Alamofire

final class DataSource: NSObject {
    private override init() { }
    
    static let shared = DataSource()
    static let stockApiUrl = "http://demo3346287.mockable.io/stock"
    
    func getStock(completionHandler: @escaping (Array<Product>?, Error?) -> ()) {
        let header = ["content-type" : "application/json"]
        Alamofire.request(DataSource.stockApiUrl,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: header).responseJSON {
                            response in
                            
                            guard response.result.isSuccess else {
                                completionHandler(nil, response.result.error)
                                return
                            }
        
                            guard let value = response.result.value as? [String: Any],
                                let stockList = value["data"] as? [[String: Any]] else {
                                    completionHandler(nil, response.result.error)
                                    return
                            }
                            
                            let stock = stockList.flatMap({ (productDict) -> Product? in
                                return Product(jsonData: productDict as [String : AnyObject])
                            })
                            
                            completionHandler(stock, nil)
        }
    }

}
