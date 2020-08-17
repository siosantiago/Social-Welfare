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

    override func viewDidLoad() {
        super.viewDidLoad()

        allAppointmentsTableView.dataSource = self
        allAppointmentsTableView.delegate = self
        
        allAppointmentsTableView.register(UINib(nibName: "AppointmentsCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        allAppointmentsTableView.rowHeight = UITableView.automaticDimension
        allAppointmentsTableView.estimatedRowHeight = 100
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
                            let time = data[self.firebaseTimeVar] as? String,
                            let date = data[self.firebaseDateVar] as? Timestamp,
                            let info = data[self.firebaseInfoVar] as? String {
                            let newAppointment = Appointment(title: title, date: date.dateValue(), info: info, time: time, id: id )
                            
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
        let dateFormatter = DateFormatter()
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AppointmentsViewCell
        
        cell.tittleViewCell.text = appointment.title
        cell.infoViewCell.text = appointment.info
        dateFormatter.dateFormat = "MMMM dd"
        let stringDate = dateFormatter.string(from: appointment.date)
        cell.dateViewCell.text = "\(stringDate) | \(appointment.time)"
        cell.tittleViewCell.textColor = .red
        cell.layer.borderColor = #colorLiteral(red: 0.03529411765, green: 0.1450980392, blue: 0.1960784314, alpha: 1)
        cell.layer.borderWidth = 5.0
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        appointmentN = allAppointments[indexPath.row].id
        print(appointmentN ?? "Nothing is in it")
        self.performSegue(withIdentifier: "addMeToAppointment", sender: self)
        
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addMeToAppointment" {
            if let destinationVC = segue.destination as? AddMeToAppointmentViewController {
                if let safeDocumentName = appointmentN {
                    destinationVC.appointID = safeDocumentName
                }
            }
        }
    }
}
