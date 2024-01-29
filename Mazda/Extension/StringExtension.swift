//
//  StringExtension.swift
//  Mazda
//
//  Created by GG on 2024/1/29.
//

import Foundation

extension String {
    static func convertTimestamp(timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
}
