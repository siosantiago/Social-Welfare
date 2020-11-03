//
//  addMeToAppointmentViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 12/08/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit
import Firebase

class AddMeToAppointmentViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    let user = Auth.auth().currentUser
    let firebaseDocName = "Appointment"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var moreInfoLabel: UILabel!
    @IBOutlet weak var studentGrdLvlLabel: UILabel!
    @IBOutlet weak var CommunityHrsLabel: UILabel!
        
    var appointInfo: String?
    var appointTime: String?
    var appointDate: String?
    var appointName: String?
    var appointID: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let title = appointName,
            let time = appointTime,
            let info = appointInfo,
            let date = appointDate{
            titleLabel.text = title
            dateLabel.text = date
            timeLabel.text = time
            infoLabel.text = info
        }
    }
    
    @IBAction func addMePressed(_ sender: UIButton) {
        if let safeUser = user, let safeID = appointID {
            let userID = safeUser.uid
            allClubMembersAdded(ID: safeID, userID: userID)
            
            print("all club member's already added")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func allClubMembersAdded(ID: String, userID: String) {
        let docRef = db.collection(firebaseDocName).document(ID)
        docRef.getDocument { (document, error) in
            if let e = error {
                print("Something went wrong retrieving data \(e.localizedDescription)")
            }else if let safeDocument = document,
                let data = safeDocument.data(),
                let idTrue = data["Club Member ID"] as? String {
                print(idTrue)
                self.dismiss(animated: true, completion: nil)
                return
            }else{
                docRef.updateData([ "Club Member ID": userID])
                
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
