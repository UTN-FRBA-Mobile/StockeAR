import UIKit

class MovementTableViewCell: UITableViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var codeLabel: UILabel!
    @IBOutlet var batchLabel: UILabel!
    
    func setup(movement: Movement) {
        self.dateLabel.text = movement.date
        self.codeLabel.text = movement.code
        self.batchLabel.text = movement.batch
    }
    
}
