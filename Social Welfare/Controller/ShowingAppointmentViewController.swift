//
//  ShowingAppointmentViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 05/09/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit

class ShowingAppointmentViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var stdGrdLvlLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var hrsGivenLabel: UILabel!
    
    var appointInfo: String?
    var appointTime: String?
    var appointDate: String?
    var appointName: String?
    var appointID: String?
       

    override func viewDidLoad() {
        super.viewDidLoad()

        if let title = appointName,
            let info = appointInfo,
            let time = appointTime {
            titleLabel.text = title
            infoLabel.text = info
            timeLabel.text = time
        }
    }

    @IBAction func startZoomCallPressed(_ sender: PrimaryButton) {
        
    }
    @IBAction func returnButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
