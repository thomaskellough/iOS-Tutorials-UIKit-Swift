//
//  ViewController.swift
//  APOD
//
//  Created by Thomas Kellough on 8/23/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    let APIKey = "cau6to6cGexfArd5RfO4Hq1pceMgWpIOpwYs1Y8E"
    let apiURL = "https://api.nasa.gov/planetary/apod?api_key="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

