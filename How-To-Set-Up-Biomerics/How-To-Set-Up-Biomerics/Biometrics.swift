//
//  Biometrics.swift
//  How-To-Set-Up-Biomerics
//
//  Created by Thomas Kellough on 8/3/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import Foundation
import LocalAuthentication

// MARK: Class initialization
class Biometrics {
    
    func authenticateUser() {
        let context = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            
            let reason = "Please login using TouchID in order to have access to this app"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, error in
                
                DispatchQueue.main.async {
                    if success {
                        // User passed
                    } else {
                        // User did not pass
                    }
                }
            }
        } else {
            // Biometrics are unavailable
        }
    }
    
}
