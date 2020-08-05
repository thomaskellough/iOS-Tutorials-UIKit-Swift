//
//  Biometrics.swift
//  How-To-Set-Up-Biomerics
//
//  Created by Thomas Kellough on 8/3/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import Foundation
import LocalAuthentication
import UIKit

// MARK: Class initialization
class Biometrics: UIViewController {
    
    var lockScreenView: UIView?
    var loginButton: UIButton?
    
    @objc func authenticateUser() {
        loginButton?.isHidden = true
        let context = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            
            let reason = "Please login using TouchID in order to have access to this app"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, error in
                
                DispatchQueue.main.async {
                    if success {
                        self?.lockScreenView?.removeFromSuperview()
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

// MARK: Configure Lockscreen
extension Biometrics {
    
    func showLockedScreen(backgroundColor: UIColor, logo: UIImage?, width: CGFloat, toView view: UIView) {
        lockScreenView = UIView()
        assert(lockScreenView != nil, "There was a problem creating the lock screen view")
        lockScreenView!.translatesAutoresizingMaskIntoConstraints = false
        lockScreenView!.backgroundColor = backgroundColor
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        assert(logo != nil, "Could not find image!")
        imageView.image = logo!
        imageView.contentMode = .scaleAspectFit
        
        lockScreenView!.addSubview(imageView)
        imageView.widthAnchor.constraint(equalTo: lockScreenView!.widthAnchor, multiplier: width).isActive = true
        imageView.centerXAnchor.constraint(equalTo: lockScreenView!.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: lockScreenView!.centerYAnchor).isActive = true
        
        view.addSubview(lockScreenView!)
        lockScreenView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        lockScreenView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        lockScreenView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lockScreenView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        configureLoginButton(to: lockScreenView!)
    }
    
}

// MARK: Configure loginbutton
extension Biometrics {
    
    func configureLoginButton(to view: UIView) {
        loginButton = UIButton(type: .custom)
        assert(loginButton != nil, "There was a problem creating the login button")
        
        loginButton?.backgroundColor = UIColor.systemGreen
        loginButton?.layer.cornerRadius = 8
        loginButton?.titleEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        loginButton?.titleLabel?.font = .preferredFont(forTextStyle: .title1)
        loginButton?.translatesAutoresizingMaskIntoConstraints = false
        loginButton?.setTitle("Login", for: .normal)
        loginButton?.setTitleColor(.white, for: .normal)
        
        view.addSubview(loginButton!)
        
        loginButton?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        loginButton?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        loginButton?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        loginButton?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        loginButton?.addTarget(self, action: #selector(authenticateUser), for: .touchUpInside)
    }
    
}

// MARK: Biometric UIAlerts
extension Biometrics {
    
    func showAlertForBiometryUnavailable() {
        let title = "Biometry unavailable"
        let message = "Your device is not configure for biometric authentication"
        showAlert(title: title, message: message, completion: nil)
        
    }
    
    func showAlertForFailedVerification() {
        let title = "Authentication failed"
        let message = "Verification failed. Please try again"
        showAlert(title: title, message: message, completion: { action in
            self.loginButton?.isHidden = false
        })
    }
    
    func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
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
