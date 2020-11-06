//
//  userViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 07/08/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit
import Firebase

class StudentUserViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    
    @IBOutlet weak var nameStudentOutlet: UILabel!
    @IBOutlet weak var lastNameOutlet: UILabel!
    @IBOutlet weak var mailOutlet: UILabel!
    @IBOutlet weak var gradeOutlet: UILabel!
    @IBOutlet weak var hoursDoneOutlet: UILabel!
    
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadInformation()
    }
    
    func loadInformation() {
        if let studentID = user?.uid {
            let docPlace = db.collection(Constants.Collections.users).document(studentID)
            docPlace.getDocument { (documentSnapshot, error) in
                if let e = error {
                    print("error retrieving data \(e)")
                }else if let data = documentSnapshot?.data(),
                    let name = data[Constants.FirebaseDictionary.dictionaryNameVar]as? String,
                    let lastName = data[Constants.FirebaseDictionary.dictionaryLastNameVar]as? String,
                    let mail = data[Constants.FirebaseDictionary.dictionaryMailVar]as? String{
                    self.nameStudentOutlet.text = name
                    self.lastNameOutlet.text = lastName
                    self.mailOutlet.text = mail
                    
                }
            }
        }
    }

}
