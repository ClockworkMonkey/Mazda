//
//  CarModel.swift
//  Mazda
//
//  Created by GG on 2023/12/20.
//

import Foundation

// MARK: - DataClass
struct CarStatus: Codable {
    let oil, gear, engineSpeed, bat: String
    let tempIn, tempOut: String
    let window: Window
    let online: String
    let time, speed, mileage: Int
    let seatWheel: SeatWheel
    let lbs, gps: Int
    let lock: Lock
    let door: Door
    let repair, relay, alarm, engine: Int
    let airConditioner: AirConditioner
    let seat: Seat
    let obdNoticeNum, noticeNum: Int

    enum CodingKeys: String, CodingKey {
        case oil, gear, engineSpeed, bat
        case tempIn = "temp_in"
        case tempOut = "temp_out"
        case window, online, time, speed, mileage, seatWheel, lbs, gps, lock, door, repair, relay, alarm, engine, airConditioner, seat
        case obdNoticeNum = "obd_notice_num"
        case noticeNum = "notice_num"
    }
}

// MARK: - AirConditioner
struct AirConditioner: Codable {
    let ac, auto, recycleAuto, recycleIn: Int
    let recycleOut, winMax, win: Int
    let leftTemp, rightTemp: String

    enum CodingKeys: String, CodingKey {
        case ac, auto
        case recycleAuto = "recycle_auto"
        case recycleIn = "recycle_in"
        case recycleOut = "recycle_out"
        case winMax = "win_max"
        case win
        case leftTemp = "left_temp"
        case rightTemp = "right_temp"
    }
}

// MARK: - Door
struct Door: Codable {
    let lf, lr, rf, rr: Int
    let hood, trunk: Int
}

// MARK: - Lock
struct Lock: Codable {
    let lf, lr, rf, rr: Int
}

// MARK: - Seat
struct Seat: Codable {
    let leftAuto, leftTemp, rightAuto, rightTemp: Int

    enum CodingKeys: String, CodingKey {
        case leftAuto = "left_auto"
        case leftTemp = "left_temp"
        case rightAuto = "right_auto"
        case rightTemp = "right_temp"
    }
}

// MARK: - SeatWheel
struct SeatWheel: Codable {
    let seatHeatMax, seatAirMax, seatHeatLeft, seatHeatRight: Int
    let seatAirLeft, seatAirRight, wheelHeat: Int

    enum CodingKeys: String, CodingKey {
        case seatHeatMax = "seat_heat_max"
        case seatAirMax = "seat_air_max"
        case seatHeatLeft = "seat_heat_left"
        case seatHeatRight = "seat_heat_right"
        case seatAirLeft = "seat_air_left"
        case seatAirRight = "seat_air_right"
        case wheelHeat = "wheel_heat"
    }
}

// MARK: - Window
struct Window: Codable {
    let lf, lr, rf, rr: Int
    let sr, srs: Int
}
