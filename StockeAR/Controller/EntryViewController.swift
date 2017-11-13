import UIKit
import SVProgressHUD

class EntryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    let cellReuseIdentifier = "EntryCell"
    var entries: Array<Entry> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRightButton()
        let entryCellNib = UINib(nibName: "EntryTableViewCell", bundle: nil)
        tableView.register(entryCellNib, forCellReuseIdentifier: cellReuseIdentifier)
        SVProgressHUD.show()
        loadEntries()
        loadHeader()
        addPullToRefresh()
    }
    
    func addPullToRefresh() {
        self.tableView.es.addPullToRefresh {
            [unowned self] in
            self.loadEntries()
            self.tableView.es.stopPullToRefresh(ignoreDate: true)
        }
    }
    
    func loadEntries() {
        DataSource.shared.getEntries { (entries, error) in
            SVProgressHUD.dismiss()
            if let entriesList = entries {
                self.reloadData(entries: entriesList)
            } else {
                self.reloadData(entries: [])
                UIAlertView(title: "Error", message: "Hubo un error en el servidor, intentá de nuevo.", delegate: nil, cancelButtonTitle: "OK").show()
            }
        }
    }
    
    func loadHeader() {
        let view = (Bundle.main.loadNibNamed("EntryTableHeaderView", owner: self, options: nil)![0] as? UIView)
        tableView.tableHeaderView = view
    }
    
    func reloadData(entries:Array<Entry>) {
        self.entries = entries
        tableView.reloadData()
    }
    
    func addRightButton() {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "add"), for: UIControlState.normal)
        button.addTarget(self, action:#selector(newEntry), for: UIControlEvents.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func newEntry() {
        let newEntryViewController = NewEntryViewController(nibName:"NewEntryViewController", bundle: nil)
        navigationController?.pushViewController(newEntryViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! EntryTableViewCell
        let entry = self.entries[indexPath.row]
        cell.setup(entry: entry)
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.white
        }
        else {
            cell.backgroundColor = UIColor.lightGray
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

}

