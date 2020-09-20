//
//  Constants.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 21/08/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit

struct Constants {
    struct FirebaseDictionary{
        static let dictionaryNameVar = "Name"
        static let dictionaryDateVar = "Date"
        static let dictionaryAgeVar = "Age"
        static let dictionaryLastNameVar = "Last Name"
        static let dictionaryMailVar = "Mail"
        static let dictionarySchoolNameVar = "School name"
        static let dictionaryHoursAwarded = "Awarded Hours"
    }
    struct StudentInfo {
        static let newStudentCollectionName = "Student's info"
        static let dictionaryIsStudent = "IsStudent"
    }
    struct ClubMemberInfo {
        static let newClubMemberCollectionName = "Club Member's info"
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
    }
    struct infoTextView {
        static let stringHolderText = "Add appointment information"
    }
    struct ColorsCell{
        static let colorChosen: [UIColor] = [#colorLiteral(red: 0.6352941176, green: 0.8352941176, blue: 0.9490196078, alpha: 1),#colorLiteral(red: 1, green: 0.8705882353, blue: 0.8117647059, alpha: 1),#colorLiteral(red: 1, green: 0.8005940223, blue: 0.1601154003, alpha: 1),#colorLiteral(red: 1, green: 0.6039215686, blue: 0.462745098, alpha: 1),#colorLiteral(red: 1, green: 0.2588235294, blue: 0.4980392157, alpha: 1)]
    }
}

