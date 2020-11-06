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
            let userRefRef = "\(Constants.Collections.users)/\(studentID)"
            NetworkService.getObject(from: userRefRef) { (result: ResultRequest<User>) in
                switch result {
                case let .success(object):
                    guard let user = object else { return }
                    self.nameStudentOutlet.text = user.name
                    self.lastNameOutlet.text = user.lastName
                    self.mailOutlet.text = user.email
                case let .failure(error):
                    print(error)
                }
            }
        }
    }

}
