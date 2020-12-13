//
//  User.swift
//  Social Welfare
//
//  Created by Luis Franzoni on 11/5/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase

struct User: Codable {
    var name: String
    var date: Timestamp
    var age: String
    var lastName: String
    var email: String
    var schoolName: String?
    var hoursAwarded: String?
    var type: UserType
    var googleMeet: String?
    var clubs: String?
    var picture: Int?
}

extension Timestamp: TimestampType {}
