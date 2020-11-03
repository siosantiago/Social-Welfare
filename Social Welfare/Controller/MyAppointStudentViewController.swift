//
//  MyAppointStudentViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 21/08/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit
import Firebase

class MyAppointStudentViewController: UIViewController {

    @IBOutlet weak var appointmentsTableView: UITableView!
    
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    let dateFormatter = DateFormatter()
    
    var myAppointments: [Appointment] = []
    var appointmentID: String?
    var appointmentDate: String = ""
    var appointmentTime: String = ""
    var appointmentInfo: String = ""
    var appointmentName: String = ""
    var appointmentGoogleMeet: String = ""
    var appointmentTutorsID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appointmentsTableView.delegate = self
        appointmentsTableView.dataSource = self
        
        appointmentsTableView.register(UINib(nibName: Constants.AppointmentTableView.nibCell, bundle: nil), forCellReuseIdentifier: Constants.AppointmentTableView.cellIdentifier)
        appointmentsTableView.rowHeight = UITableView.automaticDimension
        appointmentsTableView.estimatedRowHeight = 100
        loadAppointments()
    }
    
    func loadAppointments(){
        db.collection(Constants.AppointmentTableView.firebaseCollectionName).order(by: Constants.AppointmentTableView.firebaseDateVar).addSnapshotListener { (querySnapshot, error) in
            
            self.myAppointments = []
            if let e = error {
                print("Error retreiving data from firestore: \(e.localizedDescription)")
            }else{
                if let snapshotDocument = querySnapshot?.documents,
                    let safeUser = self.user {
                    let userID = safeUser.uid
                    for document in snapshotDocument {
                        let data = document.data()
                        let id = document.documentID
                        if let title = data[Constants.AppointmentTableView.firebaseTitleVar]as? String,
                            userID == data[Constants.AppointmentTableView.firebaseStudentID]as? String,
                            let date = data[Constants.AppointmentTableView.firebaseDateVar]as? Timestamp,
                            date.dateValue() >= Date.init(),
                            let info = data[Constants.AppointmentTableView.firebaseInfoVar]as? String{
                            self.myAppointments.append(Appointment(title: title, date: date.dateValue(), info: info, id: id))
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


extension MyAppointStudentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myAppointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myAppointment = myAppointments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.AppointmentTableView.cellIdentifier, for: indexPath) as! AppointmentsCoolTableViewCell
        
        cell.titleLabel.text = myAppointment.title
        cell.infoLabel.text = myAppointment.info
        cell.dateLabel.text = myAppointment.date.getReadableFullFormat()
        cell.timeLabel.text = myAppointment.date.getTimeFormat()
        cell.coloredView.backgroundColor = getColorForCell(colorCellNumber: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appPlace = myAppointments[indexPath.row]
        appointmentID = myAppointments[indexPath.row].id
        self.thingsToSend(title: appPlace.title, date: appPlace.date, info: appPlace.info)
        self.performSegue(withIdentifier: "studentShowInfo", sender: self)
    }
    
    // MARK: - Size of Cell and Color
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func thingsToSend(title: String, date: Date, info: String) {
        
        appointmentDate = date.getSimpleFormat()
        appointmentName = title
        appointmentInfo = info
        appointmentTime = date.getTimeFormat()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "studentShowInfo" {
            if let destinationVC = segue.destination as? ShowInfoStudentViewController {
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
