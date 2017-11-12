import UIKit

class MovementsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addRightButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        
    }

}
