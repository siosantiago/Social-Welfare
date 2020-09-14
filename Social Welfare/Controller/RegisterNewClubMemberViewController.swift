//
//  RegisterNewClubMemberViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 21/08/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit
import Firebase
import SkyFloatingLabelTextField

class RegisterNewClubMemberViewController: UIViewController, UITextViewDelegate {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var nameTextFieldRegister: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTextFieldRegister: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextFieldRegister: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextFieldRegister: SkyFloatingLabelTextField!
    @IBOutlet weak var ageTextFieldRegister: SkyFloatingLabelTextField!
    @IBOutlet weak var schoolNameTextFieldRegister: SkyFloatingLabelTextField!
    @IBOutlet weak var bottomScrollViewConstraint: NSLayoutConstraint!
    var activeTextField : UITextField? = nil
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextFieldRegister.delegate = self
        lastNameTextFieldRegister.delegate = self
        emailTextFieldRegister.delegate = self
        ageTextFieldRegister.delegate = self
        schoolNameTextFieldRegister.delegate = self
        
        // Do any additional setup after loading the view.
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterNewClubMemberViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterNewClubMemberViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
    }
    

    @IBAction func registerButtonPressed(_ sender: UIButton) {

        
        if let name = nameTextFieldRegister.text,
            let lastName = lastNameTextFieldRegister.text,
            let email = emailTextFieldRegister.text,
            let password = passwordTextFieldRegister.text,
            let age = ageTextFieldRegister.text,
            let schoolName = schoolNameTextFieldRegister.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e)
                }
                else if let uid = authResult?.user.uid {
                    self.saveDataUser(email: email, name: name, lastName: lastName, age: age, uid: uid, school: schoolName)
                }
            }
        }
    }
    
    func saveDataUser(email: String, name: String, lastName: String, age: String, uid: String, school: String) {
        
        let data = [Constants.FirebaseDictionary.dictionaryMailVar: email,
        Constants.FirebaseDictionary.dictionaryNameVar: name,
        Constants.FirebaseDictionary.dictionaryLastNameVar: lastName,
        Constants.FirebaseDictionary.dictionaryDateVar: Date().timeIntervalSince1970,
        Constants.FirebaseDictionary.dictionarySchoolNameVar: school,
        Constants.StudentInfo.dictionaryIsStudent: false,
        Constants.FirebaseDictionary.dictionaryAgeVar: age] as [String : Any]
        
        self.db.collection(Constants.ClubMemberInfo.newClubMemberCollectionName).document(uid).setData(data) { (error) in
            if let e = error {
                print("There was an issue saving data to firestroe, \(e)")
            }
            else{
                self.goToMainClubMember()
            }
        }
    }

}

extension RegisterNewClubMemberViewController: UITextFieldDelegate {
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
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        var shouldMoveViewUp = false
        
        // if active text field is not nil
        if let activeTextField = activeTextField {
            
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            
            // if the bottom of Textfield is below the top of keyboard, move up
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        
        if(shouldMoveViewUp) {
            bottomScrollViewConstraint.constant = keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // move back the root view origin to zero
        bottomScrollViewConstraint.constant = 0
    }
}
