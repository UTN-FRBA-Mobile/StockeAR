import UIKit
import Alamofire

final class DataSource: NSObject {
    private override init() { }
    
    static let shared = DataSource()
    static let stockApiUrl = "http://demo3346287.mockable.io/stock"
    static let entriesApiUrl = "http://demo3346287.mockable.io/entries"
    static let egressesApiUrl = "http://demo3346287.mockable.io/egresses"
    static let movementsApiUrl = "http://demo3346287.mockable.io/movements"
    static let newEntryApiUrl = "http://demo3346287.mockable.io/newentry"
    static let newEgressApiUrl = "http://demo3346287.mockable.io/newegress"
    static let newMovementApiUrl = "http://demo3346287.mockable.io/newmovement"
    static let clientsApiUrl = "http://demo3346287.mockable.io/clients"
    static let providersApiUrl = "http://demo3346287.mockable.io/providers"
    
    func getStock(completionHandler: @escaping (Array<Product>?, Int?) -> ()) {
        let header = ["content-type" : "application/json"]
        Alamofire.request(DataSource.stockApiUrl,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: header).responseJSON {
                            response in
                            
                            guard response.response?.statusCode == 200 else {
                                completionHandler(nil, response.response?.statusCode)
                                return
                            }
        
                            guard let value = response.result.value as? [String: Any],
                                let stockList = value["data"] as? [[String: Any]] else {
                                    completionHandler(nil, response.response?.statusCode)
                                    return
                            }
                            
                            let stock = stockList.flatMap({ (productDict) -> Product? in
                                return Product(jsonData: productDict as [String : AnyObject])
                            })
                            
                            completionHandler(stock, nil)
        }
    }
    
    func getEntries(completionHandler: @escaping (Array<Entry>?, Int?) -> ()) {
        let header = ["content-type" : "application/json"]
        Alamofire.request(DataSource.entriesApiUrl,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: header).responseJSON {
                            response in
                            
                            guard response.response?.statusCode == 200 else {
                                completionHandler(nil, response.response?.statusCode)
                                return
                            }
                            
                            guard let value = response.result.value as? [String: Any],
                                let entriesList = value["data"] as? [[String: Any]] else {
                                    completionHandler(nil, response.response?.statusCode)
                                    return
                            }
                            
                            let entries = entriesList.flatMap({ (entryDict) -> Entry? in
                                return Entry(jsonData: entryDict as [String : AnyObject])
                            })
                            
                            completionHandler(entries, nil)
        }
    }
    
    func getEgresses(completionHandler: @escaping (Array<Egress>?, Int?) -> ()) {
        let header = ["content-type" : "application/json"]
        Alamofire.request(DataSource.egressesApiUrl,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: header).responseJSON {
                            response in
                            
                            guard response.response?.statusCode == 200 else {
                                completionHandler(nil, response.response?.statusCode)
                                return
                            }
                            
                            guard let value = response.result.value as? [String: Any],
                                let egressList = value["data"] as? [[String: Any]] else {
                                    completionHandler(nil, response.response?.statusCode)
                                    return
                            }
                            
                            let egresses = egressList.flatMap({ (egressDict) -> Egress? in
                                return Egress(jsonData: egressDict as [String : AnyObject])
                            })
                            
                            completionHandler(egresses, nil)
        }
    }
    
    func getMovements(completionHandler: @escaping (Array<Movement>?, Int?) -> ()) {
        let header = ["content-type" : "application/json"]
        Alamofire.request(DataSource.movementsApiUrl,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: header).responseJSON {
                            response in
                            
                            guard response.response?.statusCode == 200 else {
                                completionHandler(nil, response.response?.statusCode)
                                return
                            }
                            
                            guard let value = response.result.value as? [String: Any],
                                let movementsList = value["data"] as? [[String: Any]] else {
                                    completionHandler(nil, response.response?.statusCode)
                                    return
                            }
                            
                            let movements = movementsList.flatMap({ (movementDict) -> Movement? in
                                return Movement(jsonData: movementDict as [String : AnyObject])
                            })
                            
                            completionHandler(movements, nil)
        }
    }
    
    func getProviders(completionHandler: @escaping (Array<String>?, Int?) -> ()) {
        let header = ["content-type" : "application/json"]
        Alamofire.request(DataSource.providersApiUrl,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: header).responseJSON {
                            response in
                            
                            guard response.response?.statusCode == 200 else {
                                completionHandler(nil, response.response?.statusCode)
                                return
                            }
                            
                            guard let value = response.result.value as? [String: Any],
                                let providers = value["data"] as? [String] else {
                                    completionHandler(nil, response.response?.statusCode)
                                    return
                            }
                            
                            completionHandler(providers, nil)
        }
    }
    
    func getClients(completionHandler: @escaping (Array<String>?, Int?) -> ()) {
        let header = ["content-type" : "application/json"]
        Alamofire.request(DataSource.clientsApiUrl,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: header).responseJSON {
                            response in
                            
                            guard response.response?.statusCode == 200 else {
                                completionHandler(nil, response.response?.statusCode)
                                return
                            }
                            
                            guard let value = response.result.value as? [String: Any],
                                let clients = value["data"] as? [String] else {
                                    completionHandler(nil, response.response?.statusCode)
                                    return
                            }
                            
                            completionHandler(clients, nil)
        }
    }
    
    func newEntry(product: Product, provider: String, completionHandler: @escaping (Int?) -> ()) {
        let header = ["content-type" : "application/json"]
        let parameters = ["id":product.productId, "batch":product.batch, "expiration_date":product.expirationDate, "amount":product.amount, "unit":product.unit, "location":product.location, "provider":provider]
        Alamofire.request(DataSource.newEntryApiUrl,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: header).responseJSON {
                            response in
                            
                            guard response.response?.statusCode == 200 else {
                                completionHandler(response.response?.statusCode)
                                return
                            }
                            
                            completionHandler(nil)
        }
    }
    
    func newMovement(product: Product, amount: String, newLocation: String, completionHandler: @escaping (Int?) -> ()) {
        let header = ["content-type" : "application/json"]
        let parameters = ["id":product.productId, "batch":product.batch, "amount":amount, "new_location":newLocation]
        Alamofire.request(DataSource.newMovementApiUrl,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: header).responseJSON {
                            response in
                            
                            guard response.response?.statusCode == 200 else {
                                completionHandler(response.response?.statusCode)
                                return
                            }
                            
                            completionHandler(nil)
        }
    }
    
    func newEgress(product: Product, amount: String, client: String, completionHandler: @escaping (Int?) -> ()) {
        let header = ["content-type" : "application/json"]
        let parameters = ["id":product.productId, "batch":product.batch, "amount":amount, "client":client]
        Alamofire.request(DataSource.newEgressApiUrl,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: header).responseJSON {
                            response in
                            
                            guard response.response?.statusCode == 200 else {
                                completionHandler(response.response?.statusCode)
                                return
                            }
                            
                            completionHandler(nil)
        }
    }

}
