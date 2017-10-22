import UIKit
import Alamofire

final class DataSource: NSObject {
    private override init() { }
    
    static let shared = DataSource()
    static let stockApiUrl = "https://stockear-stage.herokuapp.com/v1/stock_all"
    
    func getStock(completionHandler: @escaping (Array<Product>?, Error?) -> ()) {
        let header = ["content-type" : "application/json"]
        Alamofire.request(DataSource.stockApiUrl,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: header).responseJSON {
                            response in
                            
//                            guard response.result.isSuccess else {
//                                completionHandler(nil, response.result.error)
//                                return
//                            }
        
                            let product = Product(productId:"1", title:"Primer producto", amount:10, batch: 1, unit: "KG")!
                            completionHandler([product], nil)
        }
    }

}
