//
//  ViewController.swift
//  How-To-Scan-A-Barcode
//
//  Created by Thomas Kellough on 7/21/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var textLabel: UILabel!

    var avCaptureSession: AVCaptureSession!
    var avPreviewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.sizeToFit()
        
        let scanBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(scanBarcode))
        navigationItem.rightBarButtonItem = scanBarButtonItem
        
    }
    
    @objc func scanBarcode() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "scannerViewController") as? ScannerViewController {
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func updateLabel(with text: String) {
        textLabel.text = text
    }
}
