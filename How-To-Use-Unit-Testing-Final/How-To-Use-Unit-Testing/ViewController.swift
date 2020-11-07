//
//  ViewController.swift
//  How-To-Use-Unit-Testing
//
//  Created by Thomas Kellough on 11/7/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var pinNumberTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func validateTextFields() {
        let textFields = [firstNameTextField, lastNameTextField, dateOfBirthTextField, pinNumberTextField]
        
        for textField in textFields {
            textField?.validate()
        }
    }
    
    @IBAction func validateTapped(_ sender: Any) {
        validateTextFields()
        var validForm = true
        
        if let firstName = firstNameTextField.text {
            if !firstName.isValidFirstName {
                validForm = false
                firstNameTextField.invalidate()
            }
        } else {
            validForm = false
            firstNameTextField.invalidate()
        }
        
        if let lastName = lastNameTextField.text {
            if !lastName.isValidLastName {
                validForm = false
                lastNameTextField.invalidate()
            }
        } else {
            validForm = false
            lastNameTextField.invalidate()
        }
        
        if let dob = dateOfBirthTextField.text {
            if !dob.isValidDOB {
                validForm = false
                dateOfBirthTextField.invalidate()
            }
        } else {
            validForm = false
            dateOfBirthTextField.invalidate()
        }
        
        if let pin = pinNumberTextField.text {
            if !pin.isValidPin {
                validForm = false
                pinNumberTextField.invalidate()
            }
        } else {
            validForm = false
            pinNumberTextField.invalidate()
        }
        
        var title = ""
        var message = ""
        if validForm {
            title = "Success!"
            message = "All of your forms are valid"
        } else {
            title = "Oops!"
            message = "Some fields are invalid. Please correct and resubmit."
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
}

