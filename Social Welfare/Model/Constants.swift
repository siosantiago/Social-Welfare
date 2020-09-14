//
//  Constants.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 21/08/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import Foundation

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
        static let cellIdentifier = "appointmentsCell"
        static let nibCell = "AppointmentsCell"
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
}

