//
//  ServiceError.swift
//  Mazda
//
//  Created by GG on 2023/12/20.
//

import Alamofire
import Foundation

struct BackendError: Codable, Error {
    var status: String
    var message: String
}

struct ServiceError: Error {
    let initialError: AFError
    let backendError: BackendError?
}
