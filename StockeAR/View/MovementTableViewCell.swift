import UIKit

class MovementTableViewCell: UITableViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var codeLabel: UILabel!
    @IBOutlet var batchLabel: UILabel!
    @IBOutlet var toLabel: UILabel!
    @IBOutlet var fromLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    
    func setup(movement: Movement) {
        self.dateLabel.text = movement.date
        self.codeLabel.text = movement.code
        self.batchLabel.text = movement.batch
        self.toLabel.text = movement.to
        self.fromLabel.text = movement.from
        self.amountLabel.text = movement.amount
    }
    
}
