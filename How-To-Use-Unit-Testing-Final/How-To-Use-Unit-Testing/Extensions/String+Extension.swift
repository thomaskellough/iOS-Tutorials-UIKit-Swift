//
//  String+Extension.swift
//  How-To-Use-Unit-Testing
//
//  Created by Thomas Kellough on 11/7/20.
//

import Foundation

extension String {
    var isValidFirstName: Bool {
        guard self.count > 0 else { return false }
        let array = Array(self.lowercased().trimmingCharacters(in: .whitespaces))
        let characters = "abcdefghijklmnopqrstuvwxyz"
        for character in array {
            if !characters.contains(character) {
                return false
            }
        }
        
        return true
    }
    
    var isValidLastName: Bool {
        guard self.count > 0 else { return false }
        let array = Array(self.lowercased().trimmingCharacters(in: .whitespaces))
        let characters = "abcdefghijklmnopqrstuvwxyz"
        for character in array {
            // The single quote you type on your phone is different in XCode. This one needs to be tested in simulator or device.
            // E.g name O'Brien -- (Note then quote differene on your phone)
            if character == "\u{2019}" { continue }
            if !characters.contains(character) {
                return false
            }
        }
        
        return true
    }
    
    var isValidDOB: Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter.date(from: self) != nil && self.count > 8
    }
    
    var isValidPin: Bool {
        return self.count == 4 && Int(self) != nil
    }
}
