//
//  UserType.swift
//  Social Welfare
//
//  Created by Luis Franzoni on 11/5/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import Foundation

enum UserType: String, Codable, EnumDecodable {
    static let defaultDecoderValue: UserType = .student
    case student = "student"
    case clubMember = "club_member"
}

enum AppointmentType: String, Codable, EnumDecodable {
    static var defaultDecoderValue: AppointmentType = .other
    case math = "math"
    case english = "english"
    case satAct = "satAct"
    case humaties = "humanities"
    case science = "science"
    case learningSession = "learningSession"
    case personToPerson = "personToPerson"
    case other = "other"
}
