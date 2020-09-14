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
    let dateFormatter = DateFormatter()
    
    //variables
    var appointments: [Appointment] = []
    var appointmentID: String?
    var appointmentDate: String = ""
    var appointmentTime: String = ""
    var appointmentInfo: String = ""
    var appointmentName: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        appointmentsTableView.dataSource = self
        appointmentsTableView.delegate = self
        
        appointmentsTableView.register(UINib(nibName: Constants.AppointmentTableView.nibCell, bundle: nil), forCellReuseIdentifier: Constants.AppointmentTableView.cellIdentifier)
        appointmentsTableView.rowHeight = UITableView.automaticDimension
        appointmentsTableView.estimatedRowHeight = 100
        loadAppointments()
    }
    
    func loadAppointments() {
        db.collection(Constants.AppointmentTableView.firebaseCollectionName).order(by: Constants.AppointmentTableView.firebaseDateVar).addSnapshotListener { (querySnapshot, error) in
            
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
                        if let title = data[Constants.AppointmentTableView.firebaseTitleVar] as? String,
                            userID == data[Constants.AppointmentTableView.firebaseTutorID] as? String,
                            let date = data[Constants.AppointmentTableView.firebaseDateVar] as? Timestamp,
                            let info = data[Constants.AppointmentTableView.firebaseInfoVar] as? String {
                            let newAppointment = Appointment(title: title, date: date.dateValue(), info: info, id: id )
                            
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

extension AppoimentsPageController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let appointment = appointments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.AppointmentTableView.cellIdentifier, for: indexPath) as! AppointmentsViewCell
        
        cell.tittleViewCell.text = appointment.title
        cell.infoViewCell.text = appointment.info
        cell.dateViewCell.text = appointment.date.getReadableFullFormat()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appPlace = appointments[indexPath.row]
        appointmentID = appointments[indexPath.row].id
        self.thingsToSend(title: appPlace.title, date: appPlace.date, info: appPlace.info)
        self.performSegue(withIdentifier: "showAppointment", sender: self)
    }
    
    
    func thingsToSend(title: String, date: Date, info: String) {
        appointmentDate = date.getSimpleFormat()
        appointmentName = title
        appointmentInfo = info
        appointmentTime = date.getTimeFormat()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAppointment" {
            if let destinationVC = segue.destination as? ShowingAppointmentViewController {
                if let safeDocumentName = appointmentID {
                    destinationVC.appointID = safeDocumentName
                    destinationVC.appointDate = appointmentDate
                    destinationVC.appointTime = appointmentTime
                    destinationVC.appointInfo = appointmentInfo
                    destinationVC.appointName = appointmentName
                }
            }
        }
    }

}
