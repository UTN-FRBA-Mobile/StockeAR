import UIKit

class EgressTableViewCell: UITableViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var codeLabel: UILabel!
    @IBOutlet var batchLabel: UILabel!
    @IBOutlet var orderLabel: UILabel!
    @IBOutlet var fromLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    
    func setup(egress: Egress) {
        self.dateLabel.text = egress.date
        self.codeLabel.text = egress.code
        self.batchLabel.text = egress.batch
        self.orderLabel.text = egress.deliveryId
        self.fromLabel.text = egress.from
        self.amountLabel.text = egress.amount
    }
    
}
