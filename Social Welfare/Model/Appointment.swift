//
//  Appointment.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 27/07/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase

struct Appointment: Codable {
    var title: String
    var date: Timestamp
    var info: String
    var studentID: String
    var clubMemberID: String?
    var communityHoursDone: String?
    var moreInfo: String?
    var type: AppointmentType
}
