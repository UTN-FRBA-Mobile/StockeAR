import UIKit
import QRCodeReaderViewController
import SVProgressHUD

class NewEntryViewController: UIViewController, QRCodeReaderDelegate {

    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var unitTextField: UITextField!
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var batchTextField: UITextField!
    @IBOutlet var expirationDateTextField: UITextField!
    @IBOutlet var productCodeTextField: UITextField!
    var entries: Array<Entry> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        amountTextField.resignFirstResponder()
        unitTextField.resignFirstResponder()
    }
    
    @IBAction func newEntry(_ sender: Any) {
        if checkForm() {
            SVProgressHUD.show()
            let product = Product(productId: productCodeTextField.text!, amount: amountTextField.text!, batch: batchTextField.text!, unit: unitTextField.text!, location: locationTextField.text!, expirationDate: expirationDateTextField.text!)
            DataSource.shared.newEntry(product: product!) { (error) in
                SVProgressHUD.dismiss()
                if (error != nil) {
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
    
    func checkForm() -> Bool {
        return productCodeTextField.text != "" &&
        batchTextField.text != "" &&
        expirationDateTextField.text != "" &&
        amountTextField.text != "" &&
        unitTextField.text != "" &&
        locationTextField.text != ""
    }
    
    func emptyForm() {
        productCodeTextField.text = ""
        batchTextField.text = ""
        expirationDateTextField.text = ""
        amountTextField.text = ""
        unitTextField.text = ""
        locationTextField.text = ""
    }
}
