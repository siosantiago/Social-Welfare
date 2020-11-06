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
