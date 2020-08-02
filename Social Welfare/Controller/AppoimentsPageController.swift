//
//  AppoimentsPageController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 27/07/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit

class AppoimentsPageController: UIViewController {
    
    @IBOutlet weak var appointmentsTableView: UITableView!
    let cellIdentifier = "appointmentsCell"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    //variables
    var appointments: [Appointment] = [Appointment(title: "Diabetes Run 2020", date: "03/17/2020", info: "Leo's club members walking jfkjfkakkkakkkkkajfjflfljdlfjldldlldldlllddkjf"), Appointment(title: "The other run", date: "03/17/2020", info: "Leo's club members walking ")]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        appointmentsTableView.dataSource = self
        appointmentsTableView.delegate = self
        
        appointmentsTableView.register(UINib(nibName: "AppointmentsCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        appointmentsTableView.rowHeight = UITableView.automaticDimension
        appointmentsTableView.estimatedRowHeight = 100
        
        let newAppointment = Appointment(title: "Second test", date: "03/17/2020", info: "Blah blah balhs.")
        
        appointments.append(newAppointment)
    }
    

    

}

extension AppoimentsPageController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let appoint = appointments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AppointmentsViewCell
        
        cell.tittleViewCell.text = appoint.title
        cell.infoViewCell.text = appoint.info
        cell.dateViewCell.text = appoint.date
        
        
        return cell
    }
    
    
}

extension AppoimentsPageController: UITableViewDelegate {
    
}
