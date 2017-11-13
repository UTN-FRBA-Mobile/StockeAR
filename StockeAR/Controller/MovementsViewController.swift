import UIKit
import SVProgressHUD

class MovementsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    let cellReuseIdentifier = "MovementCell"
    var movements: Array<Movement> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        addRightButton()
        let movementCellNib = UINib(nibName: "MovementTableViewCell", bundle: nil)
        tableView.register(movementCellNib, forCellReuseIdentifier: cellReuseIdentifier)
        SVProgressHUD.show()
        loadMovements()
        loadHeader()
    }
    
    func loadMovements() {
        DataSource.shared.getMovements { (movements, error) in
            SVProgressHUD.dismiss()
            if let movementsList = movements {
                self.reloadData(movements: movementsList)
            } else {
                print("Error")
            }
        }
    }
    
    func loadHeader() {
        let view = (Bundle.main.loadNibNamed("MovementTableHeaderView", owner: self, options: nil)![0] as? UIView)
        tableView.tableHeaderView = view
    }
    
    func reloadData(movements:Array<Movement>) {
        self.movements = movements
        tableView.reloadData()
    }
    
    func addRightButton() {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "add"), for: UIControlState.normal)
        button.addTarget(self, action:#selector(newMovement), for: UIControlEvents.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func newMovement() {
        let newEgressViewController = NewEgressViewController(isLocal: true)
        navigationController?.pushViewController(newEgressViewController!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movements.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! MovementTableViewCell
        let movement = self.movements[indexPath.row]
        cell.setup(movement: movement)
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
