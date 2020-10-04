//
//  LoginViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 02/08/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit
import Firebase
import SkyFloatingLabelTextField

class LoginViewController: UIViewController {
    
    let segueIdentifier = "loginSegue"
    
    
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
    var activeTextField : UITextField? = nil
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                if let e = error {
                    print(e)
                }
                else{
                    self.goToMainStudent()
                }
            }
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
//        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//
//        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
//        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
//    @objc func keyboardWillShow(notification: NSNotification) {
//
//      guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//
//        // if keyboard size is not available for some reason, dont do anything
//        return
//      }
//
//      var shouldMoveViewUp = false
//
//      // if active text field is not nil
//      if let activeTextField = activeTextField {
//
//        let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
//
//        let topOfKeyboard = self.view.frame.height - keyboardSize.height
//
//        // if the bottom of Textfield is below the top of keyboard, move up
//        if bottomOfTextField > topOfKeyboard {
//          shouldMoveViewUp = true
//        }
//      }
//
//      if(shouldMoveViewUp) {
//        self.view.frame.origin.y = 0 - keyboardSize.height
//      }
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//      // move back the root view origin to zero
//      self.view.frame.origin.y = 0
//    }
    

}


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
      // set the activeTextField to the selected textfield
      self.activeTextField = textField
    }
      
    // when user click 'done' or dismiss the keyboard
    func textFieldDidEndEditing(_ textField: UITextField) {
      self.activeTextField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
