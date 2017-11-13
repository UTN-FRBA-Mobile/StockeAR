import UIKit
import QRCodeReaderViewController
import SVProgressHUD

class NewEntryViewController: UIViewController, QRCodeReaderDelegate, UIGestureRecognizerDelegate, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var picker: UIPickerView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var unitTextField: UITextField!
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var batchTextField: UITextField!
    @IBOutlet var expirationDateTextField: UITextField!
    @IBOutlet var productCodeTextField: UITextField!
    @IBOutlet var providerLabel: UILabel!
    var entries: Array<Entry> = []
    var providers: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProviderLabel()
        getProviders()
    }
    
    func getProviders() {
        DataSource.shared.getProviders { (providers, statusCode) in
            if let providersList = providers {
                self.providers = providersList
                self.picker.reloadAllComponents()
            }
            else {
                UIAlertView(title: "Error", message: "Hubo un error en el servidor, intentá de nuevo.", delegate: nil, cancelButtonTitle: "OK").show()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    func setupProviderLabel() {
        providerLabel.layer.borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0).cgColor
        providerLabel.layer.borderWidth = 1
        providerLabel.layer.cornerRadius = 4
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(NewEntryViewController.showPicker))
        tap.delegate = self
        providerLabel.addGestureRecognizer(tap)
    }
    
    @IBAction func scanProduct(_ sender: Any) {
        let reader = QRCodeReader(metadataObjectTypes: [AVMetadataObject.ObjectType.dataMatrix])
        let qrCodeReaderVC = QRCodeReaderViewController(cancelButtonTitle: "Cancelar", codeReader: reader, startScanningAtLoad: true, showSwitchCameraButton: true, showTorchButton: true)
        qrCodeReaderVC.modalPresentationStyle = UIModalPresentationStyle.formSheet
        qrCodeReaderVC.delegate = self
        qrCodeReaderVC.setCompletionWith { (result) in
            if let productCode = result {
                self.productCodeTextField.text = productCode.components(separatedBy: ";")[0]
                self.batchTextField.text = productCode.components(separatedBy: ";")[1]
                self.expirationDateTextField.text = productCode.components(separatedBy: ";")[2]
                
            }
        }
        self.present(qrCodeReaderVC, animated: true, completion: nil)
    }
    
    @IBAction func scanLocation(_ sender: Any) {
        let reader = QRCodeReader(metadataObjectTypes: [AVMetadataObject.ObjectType.code39])
        let qrCodeReaderVC = QRCodeReaderViewController(cancelButtonTitle: "Cancelar", codeReader: reader, startScanningAtLoad: true, showSwitchCameraButton: true, showTorchButton: true)
        qrCodeReaderVC.modalPresentationStyle = UIModalPresentationStyle.formSheet
        qrCodeReaderVC.delegate = self
        qrCodeReaderVC.setCompletionWith { (result) in
            if let location = result {
                self.locationTextField.text = location
            }
        }
        self.present(qrCodeReaderVC, animated: true, completion: nil)
    }
    
    func reader(_ reader: QRCodeReaderViewController!, didScanResult result: String!) {
        self.dismiss(animated: true) {
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissKeyboard() {
        amountTextField.resignFirstResponder()
        unitTextField.resignFirstResponder()
        picker.isHidden = true
    }
    
    @IBAction func newEntry(_ sender: Any) {
        if checkForm() {
            SVProgressHUD.show()
            let product = Product(productId: productCodeTextField.text!, amount: amountTextField.text!, batch: batchTextField.text!, unit: unitTextField.text!, location: locationTextField.text!, expirationDate: expirationDateTextField.text!)
            DataSource.shared.newEntry(product: product!, provider: providerLabel.text!) { (statusCode) in
                SVProgressHUD.dismiss()
                if (statusCode != nil) {
                    UIAlertView(title: "Error", message: "Hubo un error en el servidor, intentá de nuevo.", delegate: nil, cancelButtonTitle: "OK").show()
                }
                else {
                    self.emptyForm()
                    UIAlertView(title: "Hecho", message: "Se realizó la carga.", delegate: nil, cancelButtonTitle: "OK").show()
                }
            }
        }
        else {
            UIAlertView(title: "Error", message: "Completar todos los campos.", delegate: nil, cancelButtonTitle: "OK").show()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        dismissKeyboard()
    }
    
    func checkForm() -> Bool {
        return productCodeTextField.text != "" &&
        batchTextField.text != "" &&
        expirationDateTextField.text != "" &&
        amountTextField.text != "" &&
        unitTextField.text != "" &&
        locationTextField.text != "" &&
        providerLabel.text != ""
    }
    
    func emptyForm() {
        productCodeTextField.text = ""
        batchTextField.text = ""
        expirationDateTextField.text = ""
        amountTextField.text = ""
        unitTextField.text = ""
        locationTextField.text = ""
        providerLabel.text = ""
    }
    
    @objc func showPicker() {
        scrollView.setContentOffset(CGPoint(x: 0, y: 150), animated: true)
        picker.isHidden = false
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return providers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return providers[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let provider = providers[row]
        providerLabel.text = provider
        picker.isHidden = true
        scrollView.setContentOffset(CGPoint(x: 0, y: -70), animated: true)
    }
    
    
    
}
