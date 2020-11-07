//
//  UITextFieldExtension.swift
//  How-To-Use-Unit-Testing
//
//  Created by Thomas Kellough on 11/7/20.
//

import Foundation
import UIKit

extension UITextField {
    func invalidate() {
        backgroundColor = .red
        textColor = .white
    }
    
    func validate() {
        backgroundColor = .systemBackground
        textColor = .label
    }
}
