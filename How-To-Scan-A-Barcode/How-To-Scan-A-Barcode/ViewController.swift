//
//  ViewController.swift
//  How-To-Scan-A-Barcode
//
//  Created by Thomas Kellough on 8/8/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scanBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(scanBarcode))
        navigationItem.rightBarButtonItem = scanBarButtonItem
    }
    
    @objc func scanBarcode() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "scannerViewController") as? ScannerViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }


    func updateLabel() {
        // this will be where we update our label
    }
    
}

