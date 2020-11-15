//
//  FirebaseDownloadableTableViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 03/11/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit
import Firebase

class FirebaseDownloadableTableViewController: UIViewController {
    
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Load Appointment from Firebase
    func loadAppointmentsAfterSnapshotListener(appointmentsTableView: UITableView,userID: String, document: QueryDocumentSnapshot) {
            
        }
    }

        
                


