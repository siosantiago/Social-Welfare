//
//  ShowInfoStudentViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 05/09/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit

class ShowInfoStudentViewController: UIViewController {

    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var infoOutlet: UILabel!
    @IBOutlet weak var tutorGrdLvlOutlet: UILabel!
    @IBOutlet weak var timeOutlet: UILabel!
    @IBOutlet weak var hrsGrantedOutlet: UILabel!
    
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
            titleOutlet.text = title
            infoOutlet.text = info
            timeOutlet.text = time
        }
    }
    
    @IBAction func startZoomMeetingPressed(_ sender: PrimaryButton) {
        if let url = URL(string: "http://meet.google.com/new") {
             UIApplication.shared.open(url, options: [:])
         }
    }
    
    
}
