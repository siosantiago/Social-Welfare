//
//  Constants.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 21/08/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit

struct Constants {
    struct Collections {
        static let users = "users"
    }
    struct StudentInfo {
        static let dictionaryIsStudent = "Is_student"
    }
    struct AppointmentTableView {
        static let cellIdentifier = "coolDesignCell"
        static let nibCell = "AppointmentsCoolTableViewCell"
        static let firebaseCollectionName = "Appointment"
        static let firebaseTitleVar = "Title"
        static let firebaseDateVar = "Date"
        static let firebaseTimeVar = "Time"
        static let firebaseInfoVar = "Info"
        static let firebaseTutorID = "Club Member ID"
        static let firebaseStudentID = "Student ID"
        static let firebaseGoogleMeet = "Google Meet"
    }
    struct infoTextView {
        static let stringHolderText = "Add appointment information"
    }
    struct ColorsCell{
        static let colorChosen: [UIColor] = [#colorLiteral(red: 0.6352941176, green: 0.8352941176, blue: 0.9490196078, alpha: 1),#colorLiteral(red: 1, green: 0.8705882353, blue: 0.8117647059, alpha: 1),#colorLiteral(red: 1, green: 0.8005940223, blue: 0.1601154003, alpha: 1),#colorLiteral(red: 1, green: 0.6039215686, blue: 0.462745098, alpha: 1),#colorLiteral(red: 1, green: 0.2588235294, blue: 0.4980392157, alpha: 1)]
    }
    struct ClassroomLink{
        static let linkG = "http://meet.google.com/"
    }
}

