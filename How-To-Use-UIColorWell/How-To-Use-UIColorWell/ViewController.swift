//
//  ViewController.swift
//  How-To-Use-UIColorWell
//
//  Created by Thomas Kellough on 10/25/20.
//

import UIKit

class ViewController: UIViewController {
    
    var colorWell: UIColorWell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let changeBgBtn = UIButton()
        changeBgBtn.frame = CGRect(x: 80, y: 100, width: 100, height: 100)
        changeBgBtn.setTitle("Tap me", for: .normal)
        changeBgBtn.addTarget(self, action: #selector(changeBgColorWheel), for: .touchUpInside)
        view.addSubview(changeBgBtn)
        
        colorWell = UIColorWell()
        colorWell.frame = CGRect(x: 200, y: 135, width: 100, height: 100)
        colorWell.title = "My Custom Title"
        colorWell.selectedColor = .systemRed
        
        view.addSubview(colorWell)
        
    }
    
    @objc func changeBgColorWheel() {
        self.view.backgroundColor = colorWell?.selectedColor
    }
    
}
