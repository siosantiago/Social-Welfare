//
//  RegisterNewClubMemberViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 21/08/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit
import Firebase

class RegisterNewClubMemberViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var nameTextFieldRegister: UITextField!
    @IBOutlet weak var lastNameTextFieldRegister: UITextField!
    @IBOutlet weak var emailTextFieldRegister: UITextField!
    @IBOutlet weak var passwordTextFieldRegister: UITextField!
    @IBOutlet weak var ageTextFieldRegister: UITextField!
    @IBOutlet weak var schoolNameTextFieldRegister: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
