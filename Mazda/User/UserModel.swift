//
//  UserModel.swift
//  Mazda
//
//  Created by GG on 2023/12/20.
//

import Foundation

// MARK: - UserInfo
struct UserInfo: Codable {
    let token: String
    let hasPassword: Int
    let mobile: String
    let bindDev: Int
    let userRole: String
    let carInfo: CarInfo
    let userConfig: UserConfig

    enum CodingKeys: String, CodingKey {
        case token
        case hasPassword = "haspassword"
        case mobile
        case bindDev = "bind_dev"
        case userRole = "user_role"
        case carInfo
        case userConfig = "userconfig"
    }
}

// MARK: - CarInfo
struct CarInfo: Codable {
    let carId, carNo, ownerId, vin: String
    let engineNo, logoId, logoURL: String
    let carRole: Int
    let tcConfig, winConfig: CtrlConfigStr
    let seatConfig, conditionerConfig, sensorlessConfig: CtrlConfigInt
    let devInfo: DevInfo
    let borrowInfo: String?

    enum CodingKeys: String, CodingKey {
        case carId = "carid"
        case carNo = "carno"
        case ownerId = "ownerid"
        case vin
        case engineNo = "engineno"
        case logoId = "logo_id"
        case logoURL = "logo_url"
        case carRole = "car_role"
        case tcConfig = "tcconfig"
        case winConfig = "winconfig"
        case seatConfig = "seatconfig"
        case conditionerConfig = "conditionerconfig"
        case sensorlessConfig = "sensorlessconfig"
        case devInfo = "DevInfo"
        case borrowInfo = "BorrowInfo"
    }
}

// MARK: - CtrlConfigStr
struct CtrlConfigStr: Codable {
    let ctrl, state: String
}

// MARK: - CtrlConfigInt
struct CtrlConfigInt: Codable {
    let ctrl, state: String
}

// MARK: - DevInfo
struct DevInfo: Codable {
    let devId, devName, ccId, serviceTime: String
    let expiredDays: Double
    let btCode: BTCode
    let pepsConfig: String?
    let type: String
    let carNavigationID: String?

    enum CodingKeys: String, CodingKey {
        case devId = "devid"
        case devName = "dev_name"
        case ccId = "ccid"
        case serviceTime = "service_time"
        case expiredDays = "expired_days"
        case btCode = "bt_code"
        case pepsConfig = "peps_config"
        case type
        case carNavigationID = "car_navigation_id"
    }
}

// MARK: - BTCode
struct BTCode: Codable {
    let key: String
}

// MARK: - UserConfig
struct UserConfig: Codable {
    let gesturePasswd, gestureState: String

    enum CodingKeys: String, CodingKey {
        case gesturePasswd = "gesture_passwd"
        case gestureState = "gesture_state"
    }
}
