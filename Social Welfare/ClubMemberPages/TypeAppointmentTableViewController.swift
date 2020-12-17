//
//  TypeAppointmentTableViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 15/11/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit
import Firebase

class TypeAppointmentTableViewController: UIViewController {
    
    var appointType: AppointmentType?
    var appointments: [Appointment] = []
    
    @IBOutlet weak var headerTitle: UINavigationItem!
    @IBOutlet weak var typeTableVew: UITableView!
    
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        headerTitle.title = appointType?.rawValue
        typeTableVew.delegate = self
        typeTableVew.dataSource = self
        typeTableVew.register(UINib(nibName: Constants.AppointmentTableView.nibCell, bundle: nil), forCellReuseIdentifier: Constants.AppointmentTableView.cellIdentifier)
        loadAppointments()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func loadAppointments() {
        let collection = db.collection(Constants.Collections.appoinment)
        collection.order(by: Constants.AppointmentTableView.firebaseDateVar).addSnapshotListener(includeMetadataChanges: true) { (querySnapshot, error) in
            
            self.appointments = []
            if let e = error {
                print("Issue retrieving data from firestore \(e.localizedDescription)")
                
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for document in snapshotDocuments {
                        let data = document.data()
                        let id = document.documentID
                        if let title = data[Constants.AppointmentTableView.firebaseTitleVar] as? String,
                           let type = data[Constants.AppointmentTableView.firebaseType] as? String,
                           self.appointType?.rawValue == type,
                            let date = data[Constants.AppointmentTableView.firebaseDateVar] as? Timestamp,
                            (date.dateValue().isInToday || date.dateValue() >= Date.init()),
                            data[Constants.AppointmentTableView.firebaseTutorID] as? String == nil,
                            let info = data[Constants.AppointmentTableView.firebaseInfoVar] as? String {
                            print(type)
                            let newAppointment = Appointment(title: title, date: date, info: info, studentID: id, type: .defaultDecoderValue)
                            self.appointments.append(newAppointment)
                            DispatchQueue.main.async {
                                self.typeTableVew.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addMeToAppointment" {
            if let destinationVC = segue.destination as? AddMeToAppointmentViewController {
            }
        }
    }

}


extension TypeAppointmentTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let appointment = appointments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.AppointmentTableView.cellIdentifier, for: indexPath)as! AppointmentsCoolTableViewCell
        cell.titleLabel.text = appointment.title
        cell.infoLabel.text = appointment.info
        cell.dateLabel.text = appointment.date.dateValue().getReadableFullFormat()
        cell.timeLabel.text = appointment.date.dateValue().getTimeFormat()
        cell.coloredView.backgroundColor = getColorForCell(colorCellNumber: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}
