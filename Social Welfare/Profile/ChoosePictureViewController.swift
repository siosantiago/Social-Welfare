//
//  ChoosePictureViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo on 12/12/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class ChoosePictureViewController: UIViewController {
    
    let db = Firestore.firestore()
    var chosenPicture = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func choseImagePressed(_ sender: UIButton) {
            let nStr = sender.currentTitle ?? "0"
            let n = Int(nStr)
            if let number = n {
                chosenPicture = number
            }
    }
    
    func updateChosenPicture() {
        if let safeUser = Auth.auth().currentUser {
            let userID = safeUser.uid
            let userInfoRef = db.collection(Constants.Collections.users).document(userID)
            userInfoRef.getDocument { (document, error) in
                if let e = error {
                    print("Something wrong retrieving data \(e.localizedDescription)")
                }else {
                    userInfoRef.updateData(["picture": self.chosenPicture])
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        updateChosenPicture()
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
