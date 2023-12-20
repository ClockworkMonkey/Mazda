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
}

extension ServiceAPI: ServiceRequestBuilder {
    var path: String {
        switch self {
        case .userInfo:
            return "/user/appSyncUserInfo"
        case .carStatus:
            return "/car/status"
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
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .userInfo:
            return HTTPMethod.post
        case .carStatus:
            return HTTPMethod.get
        }
    }
}
