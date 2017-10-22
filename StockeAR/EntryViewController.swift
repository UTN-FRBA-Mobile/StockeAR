import UIKit
import QRCodeReaderViewController

class EntryViewController: UIViewController, QRCodeReaderDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func qrScanAction(_ sender: Any) {
        let reader = QRCodeReader(metadataObjectTypes: [AVMetadataObject.ObjectType.dataMatrix])
        let qrCodeReaderVC = QRCodeReaderViewController(cancelButtonTitle: "Cancelar", codeReader: reader, startScanningAtLoad: true, showSwitchCameraButton: true, showTorchButton: true)
        qrCodeReaderVC.modalPresentationStyle = UIModalPresentationStyle.formSheet
        qrCodeReaderVC.delegate = self
        self.present(qrCodeReaderVC, animated: true, completion: nil)
    }
    
    func reader(_ reader: QRCodeReaderViewController!, didScanResult result: String!) {
        self.dismiss(animated: true) {
            print(result)
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController!) {
        self.dismiss(animated: true, completion: nil)
    }

}

