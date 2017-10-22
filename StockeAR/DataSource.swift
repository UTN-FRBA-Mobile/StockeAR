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
        
                            let product1 = Product(productId:"1", title:"Primer producto", amount:10, batch: 1, unit: "KG")!
                            let product2 = Product(productId:"2", title:"Segundo producto", amount:1, batch: 1, unit: "KG")!
                            let product3 = Product(productId:"3", title:"Tercer producto", amount:7, batch: 1, unit: "KG")!
                            let product4 = Product(productId:"4", title:"Cuarto producto", amount:15, batch: 1, unit: "KG")!
                            let product5 = Product(productId:"5", title:"Quinto producto", amount:20, batch: 1, unit: "KG")!
                            let product6 = Product(productId:"6", title:"Sexto producto", amount:30, batch: 1, unit: "KG")!
                            let product7 = Product(productId:"7", title:"Septimo producto", amount:35, batch: 1, unit: "KG")!
                            let product8 = Product(productId:"8", title:"Octavo producto", amount:5, batch: 1, unit: "KG")!
                            
                            completionHandler([product1, product2, product3, product4, product5, product6, product7, product8], nil)
        }
    }

}
