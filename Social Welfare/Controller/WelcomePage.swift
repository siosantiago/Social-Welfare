//
//  WelcomePage.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 20/07/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit
import Firebase

class WelcomePage: UIViewController {
    
    let db = Firestore.firestore()
    let firebaseDocName = "Student's info"
    let firebaseIsStudent = "IsStudent"
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var loginButton: PrimaryButton!
    @IBOutlet weak var registerButton: PrimaryButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        welcomeLabel.text = "Social Welfare"
        checkAuth()
        //Ologout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showPage() {
        self.welcomeLabel.text = "Welcome"
        self.appIcon.isHidden = false
        self.loginButton.isHidden = false
        self.registerButton.isHidden = false
    }
    
    func checkAuth() {
        if let user = Auth.auth().currentUser {
            let userID = user.uid
            let userRefRef = "\(Constants.Collections.users)/\(userID)"
            NetworkService.getObject(from: userRefRef) { (result: ResultRequest<User>) in
                switch result {
                case let .success(object):
                    guard let user = object else { return }
                    if user.type == .student {
                        self.goToMainStudent()
                    } else {
                        self.goToMainClubMember()
                    }
                case .failure(_):
                    self.showPage()
                    self.logout()
                }
            }
        } else {
            self.showPage()
        }
    }
    
    func logout() {
        do{
            try Auth.auth().signOut()
        }catch{
            print(error)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIViewController {
    func goToMainStudent() {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let appDel: AppDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        let centerVC = mainStoryBoard.instantiateViewController(identifier: "HomeStudent")
        appDel.window?.rootViewController = centerVC
        appDel.window?.makeKeyAndVisible()
    }
    
    func goToMainClubMember() {
       let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
       
       guard let appDel: AppDelegate = UIApplication.shared.delegate as? AppDelegate else
       {
           return
       }
       let centerVC = mainStoryBoard.instantiateViewController(identifier: "HomeClubMember")
       appDel.window?.rootViewController = centerVC
       appDel.window?.makeKeyAndVisible()
    }
    
    func getColorForCell(colorCellNumber colorNumber: Int) -> UIColor{
        switch colorNumber % 5 {
        case 0:
            return Constants.ColorsCell.colorChosen[0]
        case 1:
            return Constants.ColorsCell.colorChosen[1]
        case 2:
            return Constants.ColorsCell.colorChosen[2]
        case 3:
            return Constants.ColorsCell.colorChosen[3]
        case 4:
            return Constants.ColorsCell.colorChosen[4]
        default:
            return Constants.ColorsCell.colorChosen[0]
        }
    }
}
