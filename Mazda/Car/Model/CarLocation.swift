//
//  CarLocation.swift
//  Mazda
//
//  Created by GG on 2024/2/4.
//

import Foundation

// MARK: - CarLocation
struct CarLocation: Codable {
    let address, longitude, time, date: String
    let latitude: String
    let lat, long: Double
}
