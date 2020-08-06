//
//  Biometrics.swift
//  How-To-Setup-Biometrics
//
//  Created by Thomas Kellough on 8/5/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import Foundation
import LocalAuthentication
import UIKit

// MARK: Class initialization
class Biometrics: ViewController {
    
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
                        self?.showAlertForFailedVerification()
                    }
                }
            }
        } else {
            showAlertForBiometryUnavailable()
        }
    }
    
}

// MARK: Biometric UIAlerts
extension Biometrics {
    
    func showAlertForBiometryUnavailable() {
        let title = "Biometry unavailable"
        let message = "Your device is not configure for biometric authentication"
        showAlert(title: title, message: message)
        
    }
    
    func showAlertForFailedVerification() {
        let title = "Authentication failed"
        let message = "Verification failed. Please try again"
        showAlert(title: title, message: message)
    }
    
    func showAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.topViewController()?.present(ac, animated: true, completion: nil)
    }
    
}

// MARK: UIApplication Extensions
extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
