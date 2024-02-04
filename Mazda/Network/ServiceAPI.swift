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
    case userRole
    case carStatus
    case carLocation
    case carCtrl(ctrl: String)
}

extension ServiceAPI: ServiceRequestBuilder {
    var path: String {
        switch self {
        case .userInfo:
            return "/user/appSyncUserInfo"
        case .userRole:
            return "/wxxcx/UserRoleAuthList"
        case .carLocation:
            return "/car/location"
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
        case .userRole:
            return nil
        case .carLocation:
            return [
                "carid": "1327407",
                "map_type": "1"
            ]
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
        case .userRole:
            return HTTPMethod.get
        case .carLocation:
            return HTTPMethod.get
        case .carStatus:
            return HTTPMethod.get
        case .carCtrl:
            return HTTPMethod.post
        }
    }
}
