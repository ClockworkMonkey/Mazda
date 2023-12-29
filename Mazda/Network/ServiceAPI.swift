//
//  ServiceAPI.swift
//  Mazda
//
//  Created by GG on 2023/12/19.
//

import Alamofire
import Foundation

enum ServiceAPI {
    case userInfo
    case carStatus
    case carCtrl(ctrl: String)
}

extension ServiceAPI: ServiceRequestBuilder {
    var path: String {
        switch self {
        case .userInfo:
            return "/user/appSyncUserInfo"
        case .carStatus:
            return "/car/status"
        case .carCtrl:
            return "/car/ctrl"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .userInfo:
            return nil
        case .carStatus:
            return [
                "carid": "1327407"
            ]
        case .carCtrl(let ctrl):
            return [
                "carid": "1327407",
                "boot_time": 15,
                "ctrl": ctrl
            ]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .userInfo:
            return HTTPMethod.post
        case .carStatus:
            return HTTPMethod.get
        case .carCtrl:
            return HTTPMethod.post
        }
    }
}
