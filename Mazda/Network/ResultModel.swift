//
//  ResultModel.swift
//  Mazda
//
//  Created by GG on 2023/12/18.
//

import Foundation

// MARK: - Result
struct Result<T: Codable>: Codable {
    let status: Int
    let data: T?
}

struct ResultData: Codable {
    let token: String
    let mobile: String
}
