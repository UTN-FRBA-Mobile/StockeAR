import UIKit
import Alamofire

final class DataSource: NSObject {
    private override init() { }
    
    static let shared = DataSource()
    static let stockApiUrl = "http://demo3346287.mockable.io/stock"
    static let entriesApiUrl = "http://demo3346287.mockable.io/entries"
    static let newEntryApiUrl = "http://demo3346287.mockable.io/newentry"
    
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
    
    func getEntries(completionHandler: @escaping (Array<Entry>?, Error?) -> ()) {
        let header = ["content-type" : "application/json"]
        Alamofire.request(DataSource.entriesApiUrl,
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
                                let entriesList = value["data"] as? [[String: Any]] else {
                                    completionHandler(nil, response.result.error)
                                    return
                            }
                            
                            let entries = entriesList.flatMap({ (entryDict) -> Entry? in
                                return Entry(jsonData: entryDict as [String : AnyObject])
                            })
                            
                            completionHandler(entries, nil)
        }
    }
    
    func newEntry(product: Product, provider: String, completionHandler: @escaping (Error?) -> ()) {
        let header = ["content-type" : "application/json"]
        let parameters = ["id":product.productId, "batch":product.batch, "expiration_date":product.expirationDate, "amount":product.amount, "unit":product.unit, "location":product.location, "provider":provider]
        Alamofire.request(DataSource.newEntryApiUrl,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: header).responseJSON {
                            response in
                            
                            guard response.result.isSuccess else {
                                completionHandler(response.result.error)
                                return
                            }
                            
                            completionHandler(nil)
        }
    }

}
