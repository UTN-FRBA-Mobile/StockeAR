import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet var productTitle: UILabel!
    @IBOutlet var batchLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var unitLabel: UILabel!
    
    
    func setup(product: Product) {
        self.productTitle.text = product.productId
        self.batchLabel.text = product.batch
        self.amountLabel.text = product.amount
        self.unitLabel.text = product.unit
    }
    
}
