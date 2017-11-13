import UIKit

class EntryTableViewCell: UITableViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var codeLabel: UILabel!
    @IBOutlet var receptionLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var batchLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    func setup(entry: Entry) {
        self.dateLabel.text = entry.date
        self.codeLabel.text = entry.code
        self.receptionLabel.text = entry.receptionId
        self.amountLabel.text = entry.amount
        self.batchLabel.text = entry.batch
        self.locationLabel.text = entry.location
    }
    
}
