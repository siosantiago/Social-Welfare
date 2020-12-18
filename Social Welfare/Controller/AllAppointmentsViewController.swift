//
//  AllAppointmentsViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 09/08/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit
import Firebase

class AllAppointmentsViewController: UIViewController, MyCustomCellDelegator {
    
    func callSegueFromCell(myData dataobject: AppointmentType) {
        self.appointmentType = dataobject
        self.performSegue(withIdentifier: "showTypeSegue", sender: dataobject)
    }
    
    
    let db = Firestore.firestore()
    let dateFormatter = DateFormatter()
    @IBOutlet weak var allAppointmentsTableView: UITableView!
        
    let cellIdentifier = "appointmentsCell"
    let nibCell = "AppointmentsCell"
    
    let firstNibCell = "TypeAppointTableViewCell"
    let firstCellIdentifer = "choseCell"

    var allAppointments: [Appointment] = []
    var appointmentN: String?
    var appointmentDate: String = ""
    var appointmentTime: String = ""
    var appointmentInfo: String = ""
    var appointmentName: String = ""
    var appointmentType: AppointmentType?

    override func viewDidLoad() {
        super.viewDidLoad()

        allAppointmentsTableView.dataSource = self
        allAppointmentsTableView.delegate = self
        allAppointmentsTableView.register(UINib(nibName: firstNibCell, bundle: nil), forCellReuseIdentifier: firstCellIdentifer)
        allAppointmentsTableView.register(UINib(nibName: Constants.AppointmentTableView.nibCell, bundle: nil), forCellReuseIdentifier: Constants.AppointmentTableView.cellIdentifier)
        loadAppointments()
    }
    
    func loadAppointments() {
        db.collection(Constants.Collections.appoinment).order(by: Constants.AppointmentTableView.firebaseDateVar)
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
                        if let title = data[Constants.AppointmentTableView.firebaseTitleVar] as? String,
                            let date = data[Constants.AppointmentTableView.firebaseDateVar] as? Timestamp,
                            date.dateValue() >= Date.init(),
                            data[Constants.AppointmentTableView.firebaseTutorID] as? String == nil,
                            let info = data[Constants.AppointmentTableView.firebaseInfoVar] as? String {
                            let newAppointment = Appointment(title: title, date: date, info: info, studentID: id, type: .other )
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
        return allAppointments.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: firstCellIdentifer, for: indexPath) as! TypeAppointTableViewCell
            cell.delegate = self
            
            return cell
        }else {
            let appointment = allAppointments[indexPath.row-1]
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.AppointmentTableView.cellIdentifier, for: indexPath) as! AppointmentsCoolTableViewCell
            
            cell.titleLabel.text = appointment.title
            cell.infoLabel.text = appointment.info
            cell.dateLabel.text = appointment.date.dateValue().getReadableFullFormat()
            cell.timeLabel.text = appointment.date.dateValue().getTimeFormat()
            cell.coloredView.backgroundColor = getColorForCell(colorCellNumber: indexPath.row)
            
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
        }else {
            let appPlace = allAppointments[indexPath.row-1]
            appointmentN = allAppointments[indexPath.row-1].studentID
            self.thingsToSend(title: appPlace.title, date: appPlace.date.dateValue(), info: appPlace.info)
            tableView.deselectRow(at: indexPath, animated: true)
            self.performSegue(withIdentifier: "addMeToAppointment", sender: self)
        }
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
        else if segue.identifier == "showTypeSegue" {
            if let destinationVC = segue.destination as? TypeAppointmentTableViewController,
               let safeType = appointmentType {
                destinationVC.appointType = safeType
            }
        }
    }
}
