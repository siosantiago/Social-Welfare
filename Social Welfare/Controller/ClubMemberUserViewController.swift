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
            let userRefRef = "\(Constants.Collections.users)/\(userID)"
            NetworkService.getObject(from: userRefRef) { (result: ResultRequest<User>) in
                switch result {
                case let .success(object):
                    guard let user = object else { return }
                    self.nameClbMemberLabel.text = user.name
                    self.lastNameOutlet.text = user.lastName
                    self.mailLabel.text = user.email
                    self.schoolNameLabel.text = user.schoolName
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
}
