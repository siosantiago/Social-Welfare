//
//  ShowInfoStudentViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 05/09/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class ShowInfoStudentViewController: UIViewController {

    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var infoOutlet: UILabel!
    @IBOutlet weak var tutorGrdLvlOutlet: UILabel!
    @IBOutlet weak var timeOutlet: UILabel!
    @IBOutlet weak var meetingLinkOutlet: UILabel!
    
    var appointInfo: String?
    var appointTime: String?
    var appointDate: String?
    var appointName: String?
    var appointID: String?
    
    var googleMeet: String?
       

    override func viewDidLoad() {
        super.viewDidLoad()

        if let title = appointName,
            let info = appointInfo,
            let time = appointTime {
            titleOutlet.text = title
            infoOutlet.text = info
            timeOutlet.text = time
        }
        loadAppointment()
    }
    @IBAction func copyButtonPressed(_ sender: UIButton) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = "Hello, world!"
    }
    
    @IBAction func startZoomMeetingPressed(_ sender: PrimaryButton) {
        if let url = URL(string: "http://meet.google.com/\(googleMeet ?? "new")") {
             UIApplication.shared.open(url, options: [:])
         }
    }
    
    func loadAppointment() {
        if let title = appointName {
            let appointRef = "\(Constants.Collections.appoinment)/\(title)"
            NetworkService.getObject(from: appointRef) { (result: ResultRequest<Appointment>) in
                switch result {
                case let .success(object):
                    guard let appoint = object else { return }
                    if let clubMemberID = appoint.clubMemberID {
                        self.loadGoogleMeet(clubMemberID: clubMemberID)
                    }
                case .failure(_):
                    self.meetingLinkOutlet.text = "Wait for new a Club Member"
                }
            }
        }
    }
    func loadGoogleMeet(clubMemberID: String) {
        let userRef = "\(Constants.Collections.users)/\(clubMemberID)"
        NetworkService.getObject(from: userRef) { (result: ResultRequest<User>) in
            switch result {
            case let .success(object):
                guard let user = object else { return }
                if let safeGoogleMeet = user.googleMeet {
                    self.googleMeet = safeGoogleMeet
                    self.meetingLinkOutlet.text = "http://meet.google.com/\(safeGoogleMeet)"
                }
            case .failure(_):
                print("Couldn't get the googleMeet")
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
