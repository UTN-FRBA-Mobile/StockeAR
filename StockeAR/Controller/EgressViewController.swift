import UIKit
import SVProgressHUD

class EgressViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    let cellReuseIdentifier = "EgressCell"
    var egresses: Array<Egress> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        addRightButton()
        let egressCellNib = UINib(nibName: "EgressTableViewCell", bundle: nil)
        tableView.register(egressCellNib, forCellReuseIdentifier: cellReuseIdentifier)
        SVProgressHUD.show()
        loadEgresses()
        loadHeader()
        addPullToRefresh()
    }
    
    func addPullToRefresh() {
        self.tableView.es.addPullToRefresh {
            [unowned self] in
            self.loadEgresses()
            self.tableView.es.stopPullToRefresh(ignoreDate: true)
        }
    }
    
    func loadEgresses() {
        DataSource.shared.getEgresses { (egresses, error) in
            SVProgressHUD.dismiss()
            if let egressesList = egresses {
                self.reloadData(egresses: egressesList)
            } else {
                self.reloadData(egresses: [])
                UIAlertView(title: "Error", message: "Hubo un error en el servidor, intentá de nuevo.", delegate: nil, cancelButtonTitle: "OK").show()
            }
        }
    }
    
    func loadHeader() {
        let view = (Bundle.main.loadNibNamed("EgressTableHeaderView", owner: self, options: nil)![0] as? UIView)
        tableView.tableHeaderView = view
    }
    
    func reloadData(egresses:Array<Egress>) {
        self.egresses = egresses
        tableView.reloadData()
    }
    
    func addRightButton() {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "add"), for: UIControlState.normal)
        button.addTarget(self, action:#selector(newEgress), for: UIControlEvents.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func newEgress() {
        let newEgressViewController = NewEgressViewController(isLocal: false)
        navigationController?.pushViewController(newEgressViewController!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return egresses.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! EgressTableViewCell
        let egress = self.egresses[indexPath.row]
        cell.setup(egress: egress)
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
