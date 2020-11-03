//
//  AllAppointmentsViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 09/08/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit
import Firebase
class AllAppointmentsViewController: UIViewController {
    
    let db = Firestore.firestore()
    let dateFormatter = DateFormatter()
    @IBOutlet weak var allAppointmentsTableView: UITableView!
        
    let cellIdentifier = "appointmentsCell"
    let nibCell = "AppointmentsCell"
    let firebaseCollectionName = "Appointment"
    let firebaseTitleVar = "Title"
    let firebaseDateVar = "Date"
    let firebaseTimeVar = "Time"
    let firebaseInfoVar = "Info"

    var allAppointments: [Appointment] = []
    var appointmentN: String?
    var appointmentDate: String = ""
    var appointmentTime: String = ""
    var appointmentInfo: String = ""
    var appointmentName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        allAppointmentsTableView.dataSource = self
        allAppointmentsTableView.delegate = self
        
        allAppointmentsTableView.register(UINib(nibName: Constants.AppointmentTableView.nibCell, bundle: nil), forCellReuseIdentifier: Constants.AppointmentTableView.cellIdentifier)
        loadAppointments()
    }
    
    
    
    func loadAppointments() {
        db.collection(firebaseCollectionName).order(by: firebaseDateVar)
        .addSnapshotListener { (querySnapshot, error) in
            self.allAppointments = []
            
            if let e = error {
                print("Issue retreiving data from firestore \(e)")
            }
            else{
                if let snapshotDocuments = querySnapshot?.documents{
                    for document in snapshotDocuments {
                        let data = document.data()
                        let id = document.documentID
                        if let title = data[self.firebaseTitleVar] as? String,
                            let date = data[self.firebaseDateVar] as? Timestamp,
                            date.dateValue() >= Date.init(),
                            let info = data[self.firebaseInfoVar] as? String {
                            let newAppointment = Appointment(title: title, date: date.dateValue(), info: info, id: id )
                            self.allAppointments.append(newAppointment)
                            DispatchQueue.main.async {
                                self.allAppointmentsTableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
}

extension AllAppointmentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allAppointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let appointment = allAppointments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.AppointmentTableView.cellIdentifier, for: indexPath) as! AppointmentsCoolTableViewCell
        
        cell.titleLabel.text = appointment.title
        cell.infoLabel.text = appointment.info
        cell.dateLabel.text = appointment.date.getReadableFullFormat()
        cell.timeLabel.text = appointment.date.getTimeFormat()
        cell.coloredView.backgroundColor = getColorForCell(colorCellNumber: indexPath.row)
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appPlace = allAppointments[indexPath.row]
        appointmentN = allAppointments[indexPath.row].id
        self.thingsToSend(title: appPlace.title, date: appPlace.date, info: appPlace.info)
        self.performSegue(withIdentifier: "addMeToAppointment", sender: self)
        
    }
    
    func thingsToSend(title: String, date: Date, info: String) {
        
        appointmentName = title
        appointmentDate = date.getSimpleFormat()
        appointmentInfo = info
        appointmentTime = date.getTimeFormat()
        
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
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addMeToAppointment" {
            if let destinationVC = segue.destination as? AddMeToAppointmentViewController {
                if let safeDocumentName = appointmentN {
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
