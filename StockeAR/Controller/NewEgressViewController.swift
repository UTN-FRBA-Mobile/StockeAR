import UIKit
import SVProgressHUD
import QRCodeReaderViewController

class NewEgressViewController: UIViewController, UIScrollViewDelegate, SearchStockDelegate, QRCodeReaderDelegate, UIGestureRecognizerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var newLocationTitleLabel: UILabel!
    @IBOutlet var picker: UIPickerView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var productLabel: UILabel!
    @IBOutlet var batchTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var newLocationLabel: UILabel!
    @IBOutlet var scanButton: UIButton!
    var clients: Array<String> = []
    
    var maxAmount: Int = 0
    var unit: String = ""
    var isLocal: Bool
    
    init?(isLocal: Bool) {
        self.isLocal = isLocal
        super.init(nibName: "NewEgressViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNewLocationLabel()
        setupView()
        getClients()
    }
    
    func setupView() {
        if isLocal {
            scanButton.isHidden = false
        }
        else {
            scanButton.isHidden = true
            addTapGesture()
            newLocationTitleLabel.text = "Cliente"
        }
    }
    
    func getClients() {
        DataSource.shared.getClients { (clients, statusCode) in
            if let clientsList = clients {
                self.clients = clientsList
                self.picker.reloadAllComponents()
            }
            else {
                UIAlertView(title: "Error", message: "Hubo un error en el servidor, intentá de nuevo.", delegate: nil, cancelButtonTitle: "OK").show()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(NewEgressViewController.showPicker))
        tap.delegate = self
        newLocationLabel.addGestureRecognizer(tap)
    }
    
    func setupNewLocationLabel() {
        newLocationLabel.layer.borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0).cgColor
        newLocationLabel.layer.borderWidth = 1
        newLocationLabel.layer.cornerRadius = 4
    }
    
    func dismissKeyboard() {
        amountTextField.resignFirstResponder()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        dismissKeyboard()
        picker.isHidden = true
    }

    @IBAction func scanNewLocation(_ sender: Any) {
        let reader = QRCodeReader(metadataObjectTypes: [AVMetadataObject.ObjectType.code39])
        let qrCodeReaderVC = QRCodeReaderViewController(cancelButtonTitle: "Cancelar", codeReader: reader, startScanningAtLoad: true, showSwitchCameraButton: true, showTorchButton: true)
        qrCodeReaderVC.modalPresentationStyle = UIModalPresentationStyle.formSheet
        qrCodeReaderVC.delegate = self
        qrCodeReaderVC.setCompletionWith { (result) in
            if let location = result {
                self.newLocationLabel.text = location
            }
        }
        self.present(qrCodeReaderVC, animated: true, completion: nil)
    }
    
    func reader(_ reader: QRCodeReaderViewController!, didScanResult result: String!) {
        self.dismiss(animated: true) {
        }
    }
    
    @IBAction func searchProduct(_ sender: Any) {
        let stockViewController = StockViewController(nibName:"StockViewController", bundle: nil)
        stockViewController.shouldReturnProduct = true
        stockViewController.delegate = self
        navigationController?.pushViewController(stockViewController, animated: true)
    }
    
    func didSelect(product: Product) {
        productLabel.text = product.productId
        locationTextField.text = product.location
        batchTextField.text = product.batch
        maxAmount = Int(product.amount)!
        unit = product.unit
    }
    
    @IBAction func newEgress(_ sender: Any) {
        if checkForm() {
            if Int(amountTextField.text!)! > maxAmount {
                UIAlertView(title: "Error", message: "La cantidad debe ser menor a la disponible", delegate: nil, cancelButtonTitle: "OK").show()
                return
            }
        }
        else {
            UIAlertView(title: "Error", message: "Completar todos los campos.", delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        let product = Product(productId: productLabel.text!, amount: amountTextField.text!, batch: batchTextField.text!, unit: unit, location: "", expirationDate: "")
        if isLocal {
            DataSource.shared.newMovement(product: product!, amount: amountTextField.text!, newLocation: newLocationLabel.text!, completionHandler: { (statusCode) in
                if (statusCode != nil) {
                    UIAlertView(title: "Error", message: "Hubo un error en el servidor, intentá de nuevo.", delegate: nil, cancelButtonTitle: "OK").show()
                }
                else {
                    self.emptyForm()
                    UIAlertView(title: "Hecho", message: "Se realizó la carga.", delegate: nil, cancelButtonTitle: "OK").show()
                }
            })
        }
        else {
            DataSource.shared.newEgress(product: product!, amount: amountTextField.text!, client: newLocationLabel.text!, completionHandler: { (statusCode) in
                if (statusCode != nil) {
                    UIAlertView(title: "Error", message: "Hubo un error en el servidor, intentá de nuevo.", delegate: nil, cancelButtonTitle: "OK").show()
                }
                else {
                    self.emptyForm()
                    UIAlertView(title: "Hecho", message: "Se realizó la carga.", delegate: nil, cancelButtonTitle: "OK").show()
                }
            })
        }
    }
    
    func emptyForm() {
        productLabel.text = "-"
        batchTextField.text = ""
        locationTextField.text = ""
        amountTextField.text = ""
        newLocationLabel.text = ""
    }
    
    func checkForm() -> Bool {
        return batchTextField.text != "" && amountTextField.text != "" && newLocationLabel.text != ""
    }
    
    @objc func showPicker() {
        scrollView.setContentOffset(CGPoint(x: 0, y: 150), animated: true)
        picker.isHidden = false
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return clients.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return clients[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let client = clients[row]
        newLocationLabel.text = client
        picker.isHidden = true
        scrollView.setContentOffset(CGPoint(x: 0, y: -70), animated: true)
    }
    
}
