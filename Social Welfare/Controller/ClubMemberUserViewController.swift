//
//  ClubMemberUserViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 23/08/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit
import Firebase

class ClubMemberUserViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var nameClbMemberLabel: UILabel!
    @IBOutlet weak var lastNameOutlet: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var gradeLvlLabel: UILabel!
    @IBOutlet weak var hrsDoneLabel: UILabel!
    @IBOutlet weak var schoolNameLabel: UILabel!
    
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadInformation()
    }
    
    func loadInformation() {
        if let userID = user?.uid {
            let docPlace = db.collection(Constants.ClubMemberInfo.newClubMemberCollectionName).document(userID)
            docPlace.getDocument { (docSnapshot, error) in
                if let e = error {
                    print("error retrieving data \(e.localizedDescription)")
                }else if let data = docSnapshot?.data(),
                    let name = data[Constants.FirebaseDictionary.dictionaryNameVar]as? String,
                    let lastName = data[Constants.FirebaseDictionary.dictionaryLastNameVar]as? String,
                    let mail = data[Constants.FirebaseDictionary.dictionaryMailVar]as? String,
                    let schoolName = data[Constants.FirebaseDictionary.dictionarySchoolNameVar]as? String {
                    self.nameClbMemberLabel.text = name
                    self.lastNameOutlet.text = lastName
                    self.mailLabel.text = mail
                    self.schoolNameLabel.text = schoolName
                }
            }
        }
    }
}
