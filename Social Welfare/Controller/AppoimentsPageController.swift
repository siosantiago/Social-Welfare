//
//  AppoimentsPageController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 27/07/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit
import Firebase

class AppoimentsPageController: UIViewController {
    
    @IBOutlet weak var appointmentsTableView: UITableView!
    
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    let cellIdentifier = "appointmentsCell"
    let nibCell = "AppointmentsCell"
    let firebaseCollectionName = "Appointment"
    let firebaseTitleVar = "Title"
    let firebaseDateVar = "Date"
    let firebaseTimeVar = "Time"
    let firebaseInfoVar = "Info"
    let firebaseTutorID = "Club Member ID"
    
    //variables
    var appointments: [Appointment] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        appointmentsTableView.dataSource = self
        appointmentsTableView.delegate = self
        
        appointmentsTableView.register(UINib(nibName: "AppointmentsCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        appointmentsTableView.rowHeight = UITableView.automaticDimension
        appointmentsTableView.estimatedRowHeight = 100
        loadAppointments()
    }
    
    func loadAppointments() {
        db.collection(firebaseCollectionName).order(by: firebaseDateVar).addSnapshotListener { (querySnapshot, error) in
            
            self.appointments = []
            
            if let e = error {
                print("Issue retreiving data from firestore \(e)")
            }
            else{
                if let snapshotDocuments = querySnapshot?.documents,
                    let safeUser = self.user{
                    let userID = safeUser.uid
                    for document in snapshotDocuments {
                        let data = document.data()
                        let id = document.documentID
                        if let title = data[self.firebaseTitleVar] as? String,
                            userID == data[self.firebaseTutorID] as? String,
                            let time = data[self.firebaseTimeVar] as? String,
                            let date = data[self.firebaseDateVar] as? Timestamp,
                            let info = data[self.firebaseInfoVar] as? String {
                            let newAppointment = Appointment(title: title, date: date.dateValue(), info: info, time: time, id: id )
                            
                            self.appointments.append(newAppointment)
                            DispatchQueue.main.async {
                                self.appointmentsTableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
}

extension AppoimentsPageController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let appointment = appointments[indexPath.row]
        let dateFormatter = DateFormatter()
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AppointmentsViewCell
        
        cell.tittleViewCell.text = appointment.title
        cell.infoViewCell.text = appointment.info
        dateFormatter.dateFormat = "MMMM dd"
        let stringDate = dateFormatter.string(from: appointment.date)
        cell.dateViewCell.text = "\(stringDate) | \(appointment.time)"
        
        
        return cell
    }
    
    
}

extension AppoimentsPageController: UITableViewDelegate {
    
}
