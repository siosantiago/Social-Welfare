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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
//        do{
//            try Auth.auth().signOut()
//
//        }catch{
//            print(error)
//        }
        checkAuth()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func checkAuth(){
        if Auth.auth().currentUser != nil {
            // User is signed in.
            // ...
            if let user = Auth.auth().currentUser {
                let userID = user.uid
                let docRefStudent = db.collection(Constants.StudentInfo.newStudentCollectionName).document(userID)
                let docRefClubMember = db.collection(Constants.ClubMemberInfo.newClubMemberCollectionName).document(userID)
                docRefStudent.getDocument { (document, error) in
                    if let e = error {
                        print("Something went wrong retrieving data \(e.localizedDescription)")
                    }else if let safeDocument = document,
                        let data = safeDocument.data(){
                        if data[self.firebaseIsStudent]as? Bool == true {
                            self.goToMainStudent()
                        }
                    }
                }
                docRefClubMember.getDocument { (document, error) in
                    if let e = error {
                        print("Something went wrong retrieving data \(e.localizedDescription)")
                    }else if let safeDocument = document,
                        let data = safeDocument.data(){
                        if data[self.firebaseIsStudent]as? Bool == false {
                            self.goToMainClubMember()
                        }
                    }
                }
            }
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
