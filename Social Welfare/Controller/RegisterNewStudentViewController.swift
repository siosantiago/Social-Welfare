//
//  RegisterNewStudentViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 06/08/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit
import Firebase

class RegisterNewStudentViewController: UIViewController {
    
    let db = Firestore.firestore()

    
    @IBOutlet weak var nameStudentAccountTextField: UITextField!
    @IBOutlet weak var lastNameStudentAccountTextField: UITextField!
    @IBOutlet weak var emailStudentAccountTextField: UITextField!
    @IBOutlet weak var passwordStudentAccountTextField: UITextField!
    @IBOutlet weak var ageStudentAccountPickerView: UIPickerView!
    
    var pickerViewData: [String] = []
    var ageChosen: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ageStudentAccountPickerView.dataSource = self
        ageStudentAccountPickerView.delegate = self
        for age in 1...29 {
            pickerViewData.append(String(age))
        }
        pickerViewData.append("+30")
    }
    
    
    @IBAction func registerNewStudentAccountPressed(_ sender: PrimaryButton) {
        if let email = emailStudentAccountTextField.text,
            let password = passwordStudentAccountTextField.text,
            let name = nameStudentAccountTextField.text,
            let lastName = lastNameStudentAccountTextField.text,
            let age = ageChosen {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e)
                }
                else if let uid = authResult?.user.uid {
                    self.saveDataUser(email: email, name: name, lastName: lastName, age: age, uid: uid)
                }
            }
        }
    }
    
    func saveDataUser(email: String, name: String, lastName: String, age: String, uid: String) {
        
        let data = [Constants.FirebaseDictionary.dictionaryMailVar: email,
        Constants.FirebaseDictionary.dictionaryNameVar: name,
        Constants.FirebaseDictionary.dictionaryLastNameVar: lastName,
        Constants.FirebaseDictionary.dictionaryDateVar: Date().timeIntervalSince1970,
        Constants.StudentInfo.dictionaryIsStudent: true,
        Constants.FirebaseDictionary.dictionaryAgeVar: age] as [String : Any]
        
        self.db.collection(Constants.StudentInfo.newStudentCollectionName).document(uid).setData(data) { (error) in
            if let e = error {
                print("There was an issue saving data to firestroe, \(e)")
            }
            else{
                self.goToMainStudent()
            }
        }
    }
}

extension RegisterNewStudentViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ageChosen = pickerViewData[row]
    }
    
    
    
}

