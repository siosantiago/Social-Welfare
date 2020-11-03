//
//  FirebaseDownloadableTableViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 03/11/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit
import Firebase

class FirebaseDownloadableTableViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    // MARK: - Load Appointment from Firebase
    func loadAppointments() -> [Appointment] {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        var myAppointments: [Appointment] = []
        db.collection(Constants.AppointmentTableView.firebaseCollectionName).order(by: Constants.AppointmentTableView.firebaseDateVar).addSnapshotListener { (querySnapshot, error) in
            
            myAppointments = []
            if let e = error {
                print("Error retreiving data from firestore: \(e.localizedDescription)")
            }else{
                if let snapshotDocument = querySnapshot?.documents,
                   let safeUser = user {
                    let userID = safeUser.uid
                    for document in snapshotDocument {
                        let data = document.data()
                        let id = document.documentID
                        if let title = data[Constants.AppointmentTableView.firebaseTitleVar]as? String,
                           userID == data[Constants.AppointmentTableView.firebaseStudentID]as? String,
                           let date = data[Constants.AppointmentTableView.firebaseDateVar]as? Timestamp,
                           date.dateValue() >= Date.init(),
                           let info = data[Constants.AppointmentTableView.firebaseInfoVar]as? String{
                            myAppointments.append(Appointment(title: title, date: date.dateValue(), info: info, id: id))
                        }
                    }
                }
            }
        }
        return myAppointments
    }



    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
