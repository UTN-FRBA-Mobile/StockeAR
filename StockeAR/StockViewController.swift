import SVProgressHUD
import UIKit

class StockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var products: Array<Product> = []
    @IBOutlet var tableView: UITableView!
    let cellReuseIdentifier = "ProductCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        let campaignCellNib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tableView.register(campaignCellNib, forCellReuseIdentifier: cellReuseIdentifier)
        SVProgressHUD.show()
        loadStock()
    }

    func loadStock() {
        DataSource.shared.getStock { (products, error) in
            SVProgressHUD.dismiss()
            if let productList = products {
                self.reloadData(products: productList)
            } else {
                print("Error")
            }
        }
    }
    
    func reloadData(products:Array<Product>) {
        self.products = products
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ProductTableViewCell
        let product = self.products[indexPath.row]
        cell.setup(product: product)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
