import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet var productTitle: UILabel!
    func setup(product: Product) {
        self.productTitle.text = product.title
    }
    
}
