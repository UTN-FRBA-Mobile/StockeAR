import SVProgressHUD
import UIKit

class StockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    let cellReuseIdentifier = "ProductCell"
    var products: Array<Product> = []
    var productsFiltered: Array<Product> = []

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
        if shouldFilter() {
            self.productsFiltered = products
        }
        else {
            self.products = products
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldFilter() {
            return productsFiltered.count
        }
        
        return products.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ProductTableViewCell
        let product: Product
        if shouldFilter() {
            product = self.productsFiltered[indexPath.row]
        }
        else {
            product = self.products[indexPath.row]
        }
        cell.setup(product: product)
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            reloadData(products: products)
        } else {
            let filtered = products.filter { $0.title.contains(searchText) }
            reloadData(products: filtered)
        }
    }
    
    func shouldFilter() -> Bool {
        return searchBar.text != ""
    }

}
