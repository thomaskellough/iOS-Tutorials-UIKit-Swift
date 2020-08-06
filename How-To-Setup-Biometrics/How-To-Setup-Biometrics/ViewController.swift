//
//  ViewController.swift
//  How-To-Setup-Biometrics
//
//  Created by Thomas Kellough on 8/5/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var biometrics: Biometrics?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        biometrics = Biometrics()
        biometrics?.authenticateUser()
    }

}

