import SVProgressHUD
import UIKit
import ESPullToRefresh

protocol SearchStockDelegate: NSObjectProtocol {
    func didSelect(product: Product)
}

class StockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    weak var delegate: SearchStockDelegate?
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    let cellReuseIdentifier = "ProductCell"
    var products: Array<Product> = []
    var productsFiltered: Array<Product> = []
    var shouldReturnProduct: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        let productCellNib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tableView.register(productCellNib, forCellReuseIdentifier: cellReuseIdentifier)
        loadStock()
        loadHeader()
        addPullToRefresh()
    }
    
    func addPullToRefresh() {
        self.tableView.es.addPullToRefresh {
            [unowned self] in
            self.loadStock()
            self.tableView.es.stopPullToRefresh(ignoreDate: true)
        }
    }

    func loadStock() {
        SVProgressHUD.show()
        DataSource.shared.getStock { (products, error) in
            SVProgressHUD.dismiss()
            if let productList = products {
                self.reloadData(products: productList)
            } else {
                self.reloadData(products: [])
                UIAlertView(title: "Error", message: "Hubo un error en el servidor, intentá de nuevo.", delegate: nil, cancelButtonTitle: "OK").show()
            }
        }
    }
    
    func loadHeader() {
        let view = (Bundle.main.loadNibNamed("ProductTableHeaderView", owner: self, options: nil)![0] as? UIView)
        tableView.tableHeaderView = view
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
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.white
        }
        else {
            cell.backgroundColor = UIColor.lightGray
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if shouldReturnProduct {
            let product: Product
            if shouldFilter() {
                product = self.productsFiltered[indexPath.row]
            }
            else {
                product = self.products[indexPath.row]
            }
            self.navigationController?.popViewController(animated: true)
            self.navigationController?.isNavigationBarHidden = false
            delegate?.didSelect(product: product)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            reloadData(products: products)
        } else {
            let filtered = products.filter { $0.productId.contains(searchText) }
            reloadData(products: filtered)
        }
    }
    
    func shouldFilter() -> Bool {
        return searchBar.text != ""
    }

}
