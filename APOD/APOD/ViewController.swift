//
//  ViewController.swift
//  APOD
//
//  Created by Thomas Kellough on 8/23/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import Alamofire
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
        
        view.backgroundColor = .systemBackground
        
        fetchAPOD()
    }

    func fetchAPOD() {
        let request = AF.request(apiURL + APIKey)
        request.responseDecodable(of: APOD.self) { response in
            
            guard response.error == nil else {
                self.errorOccurred()
                
                return
            }
            
            guard let apod = response.value else { return }
            
            self.loadDetails(apod: apod)
            self.loadImage(urlString: apod.url)
        }
    }
    
    func loadDetails(apod: APOD) {
        dateLabel.text = apod.date
        dateLabel.numberOfLines = 0
        dateLabel.font = .preferredFont(forTextStyle: .callout)
        dateLabel.adjustsFontForContentSizeCategory = true

        titleLabel.text = apod.title
        titleLabel.textColor = .systemGreen
        titleLabel.numberOfLines = 0
        titleLabel.font = .preferredFont(forTextStyle: .title1)
        dateLabel.adjustsFontForContentSizeCategory = true

        explanationLabel.text = apod.explanation
        explanationLabel.numberOfLines = 0
        explanationLabel.font = .preferredFont(forTextStyle: .body)
        explanationLabel.adjustsFontForContentSizeCategory = true
        
        if let copyright = apod.copyright {
            copyrightLabel.text = "Copyright: \(copyright)"
            copyrightLabel.numberOfLines = 0
            copyrightLabel.font = .preferredFont(forTextStyle: .caption1)
        } else {
            copyrightLabel.isHidden = true
        }
    }
    
    func loadImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }

        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                    }
                }
            }
        }
    }
    
    func errorOccurred() {
        titleLabel.text = "An error occurred. No data could be found. Please try again later"
        titleLabel.numberOfLines = 0
    }
    
}

