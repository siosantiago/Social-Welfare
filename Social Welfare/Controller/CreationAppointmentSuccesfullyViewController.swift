//
//  CreationAppointmentSuccesfullyViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 07/08/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit

class CreationAppointmentSuccesfullyViewController: UIViewController {
    
    @IBOutlet weak var congratulationsLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    
    var isAppointValid: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let answer = isAppointValid {
            if answer == false {
                congratulationsLabel.text = "Uh oh"
                successLabel.text = "Sorry please try again something went wrong"
            }
        }
    }
    
    
}
