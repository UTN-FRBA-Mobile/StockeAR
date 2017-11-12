import UIKit

class EntryTableViewCell: UITableViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var providerLabel: UILabel!
    @IBOutlet var receptionLabel: UILabel!
    
    func setup(entry: Entry) {
        self.dateLabel.text = entry.date
        self.providerLabel.text = entry.provider
        self.receptionLabel.text = entry.receptionId
    }
    
}
