//
//  RegisterNewStudentViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 06/08/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import SkyFloatingLabelTextField

class RegisterNewStudentViewController: UIViewController {
    
    let db = Firestore.firestore()

    
    @IBOutlet weak var nameStudentAccountTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameStudentAccountTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailStudentAccountTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordStudentAccountTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var ageStudentAccountPickerView: UIPickerView!
    
    var pickerViewData: [String] = []
    var ageChosen: String?
    var activeTextField : UITextField? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ageStudentAccountPickerView.dataSource = self
        ageStudentAccountPickerView.delegate = self
        nameStudentAccountTextField.delegate = self
        lastNameStudentAccountTextField.delegate = self
        emailStudentAccountTextField.delegate = self
        passwordStudentAccountTextField.delegate = self
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
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
        
        let user = User(name: name, date: Timestamp(date: Date()), age: age,
                        lastName: lastName, email: email,
                        schoolName: nil, hoursAwarded: nil,
                        type: .student)
        
        NetworkService.createObject(to: Constants.Collections.users, key: uid, object: user) { (result) in
            switch result {
            case .success(_):
                self.goToMainStudent()
            case let .failure(error):
                print("There was an issue saving data to firestroe, \(error.localizedDescription)")
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

extension RegisterNewStudentViewController: UITextFieldDelegate {
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
