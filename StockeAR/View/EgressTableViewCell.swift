import UIKit

class EgressTableViewCell: UITableViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var clientLabel: UILabel!
    @IBOutlet var deliveryLabel: UILabel!
    
    func setup(egress: Egress) {
        self.dateLabel.text = egress.date
        self.clientLabel.text = egress.client
        self.deliveryLabel.text = egress.deliveryId
    }
    
}
