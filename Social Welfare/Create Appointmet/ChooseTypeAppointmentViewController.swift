//
//  ChooseTypeAppointmentViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 13/11/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit

class ChooseTypeAppointmentViewController: UIViewController {
    
    var typeAppoint: AppointmentType?
    let segueIdentifier = "goCreateAppointSegue"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func mathChooseButtonPressed(_ sender: Any) {
        choseHelp(in: AppointmentType.math)
    }
    
    @IBAction func satActChooseButtonPressed(_ sender: Any) {
        choseHelp(in: AppointmentType.satAct)
    }
    
    @IBAction func englishChooseButtonPressed(_ sender: Any) {
        choseHelp(in: AppointmentType.english)
    }
    
    @IBAction func scienceChooseButtonPressed(_ sender: Any) {
        choseHelp(in: AppointmentType.science)
    }
    
    @IBAction func humanitiesChooseButtonPressed(_ sender: Any) {
        choseHelp(in: AppointmentType.humaties)
    }
    
    @IBAction func otherChooseButtonPressed(_ sender: Any) {
        choseHelp(in: AppointmentType.other)
    }
    
    func choseHelp(in subject: AppointmentType) {
        typeAppoint = subject
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueIdentifier {
            if let destinationVC = segue.destination as? CreateAppointmentViewController {
                destinationVC.type = self.typeAppoint
            }
        }
    }
    
}
