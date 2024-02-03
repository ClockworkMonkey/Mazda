//
//  UserRoleModel.swift
//  Mazda
//
//  Created by GG on 2024/2/3.
//

import Foundation

// MARK: - UserRole
struct UserRole: Codable {
    let carinfo: Carinfo

    enum CodingKeys: String, CodingKey {
        case carinfo
    }
}

// MARK: - Carinfo
struct Carinfo: Codable {
    let lastPosition: String

    enum CodingKeys: String, CodingKey {
        case lastPosition
    }
}
